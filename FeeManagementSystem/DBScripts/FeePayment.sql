USE [FMS]
GO
/****** Object:  StoredProcedure [dbo].[FMS_FeePayment]    Script Date: 22-04-2023 17:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FMS_FeePayment]
@ID NVARCHAR(100),
@PayFee INT

AS

BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @IDValue NVARCHAR(100),
		@FeeID NVARCHAR(100),
		@FeeToBePaid INT,
		@FeeDue INT,
		@FeePaidDate DATETIME = GETDATE(),
		@FeePaid INT
		--@LatestFeePaid INT = @FeePaid


		  

		SELECT @IDValue = sd.IDValue,@FeeID = fd.FeeID,@FeeToBePaid = fd.FeeToBePaid,@FeePaid = fd.FeePaid FROM StudentDetails sd
		INNER JOIN FeeDetails fd on sd.IDValue = fd.IDValue
		WHERE sd.ID = @ID 

		SET @FeePaid = @FeePaid+@PayFee
		SET @FeeDue = @FeeToBePaid-@FeePaid

		UPDATE FeeDetails
		SET FeePaid = @FeePaid,
		FeeDue = @FeeDue
		wHERE IDValue = @IDValue

		

		INSERT INTO FeeDetailsHistory(ID,IDValue,FeeID,FeeToBePaid,AmmountPaid,FeePaid,FeeDue,FeePaidDate)
		VALUES(@ID,@IDValue,@FeeID,@FeeToBePaid,@PayFee,@FeePaid,@FeeDue,@FeePaidDate)
	END TRY

	BEGIN CATCH
		EXEC FMS_GetErrorInfo
	END CATCH
END










