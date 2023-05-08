USE [FMS]
GO
/****** Object:  StoredProcedure [dbo].[FMS_InsertStudentDetails]    Script Date: 22-04-2023 16:44:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FMS_InsertStudentDetails]
@ID NVARCHAR(100),
@StudentName NVARCHAR(100),
@Class NVARCHAR(100),
@Section NVARCHAR(100),
@DateOfJoining NVARCHAR(100) = NULL,
@FatherName NVARCHAR(100) = NULL,
@MotherName NVARCHAR(100) = NULL,
@GuardianName NVARCHAR(100) = NULL,
@MobileNumber NVARCHAR(100) = NULL,
@AlternateMobileNumber NVARCHAR(100) = NULL,
@DateOfBirth NVARCHAR(100) = NULL,
@Street NVARCHAR(100) = NULL,
@DoorNumber NVARCHAR(100) = NULL,
@City NVARCHAR(100) = NULL,
@Village NVARCHAR(100) = NULL,
@PinCode NVARCHAR(100) = NULL,
@StateName NVARCHAR(100) = NULL,
@Country NVARCHAR(100) = NULL,
@FeeToBePaid INT,
@FeePaid INT = NULL,
@FeeDue INT = NULL

AS 

BEGIN

	SET NOCOUNT ON
	
	BEGIN TRY
		DECLARE @IDValue NVARCHAR(100) = NEWID(),
		@StudentNameValue NVARCHAR(100) = NEWID(),
		@ClassValue NVARCHAR(100),
		@SectionValue NVARCHAR(100),
		@FeeID NVARCHAR(100) = NEWID()

		SET @FeePaid = 0
		SET @FeeDue = @FeeToBePaid

		SELECT @ClassValue = ClassValue FROM ClassDetails WHERE Class = @Class
		SELECT @SectionValue = SectionValue FROM SectionDetails WHERE Section = @Section

		
		SELECT @DateOfJoining=CONVERT(date, @DateOfJoining, 105)
		SELECT @DateOfBirth=CONVERT(date, @DateOfBirth, 105)



		INSERT INTO StudentDetails(ID,IDValue,StudentName,StudentNameValue,Class,ClassValue,Section,SectionValue,DateOfJoining)
		VALUES(@ID,@IDValue,@StudentName,@StudentNameValue,@Class,@ClassValue,@Section,@SectionValue,@DateOfJoining)

		INSERT INTO PersonalDetails(ID,IDValue,FatherName,MotherName,GuardianName,MobileNumber,AlternateMobileNumber,DateOfBirth)
		VALUES(@ID,@IDValue,@FatherName,@MotherName,@GuardianName,@MobileNumber,@AlternateMobileNumber,@DateOfBirth)

		INSERT INTO AddressDetails(ID,IDValue,Street,DoorNumber,City,Village,PinCode,StateName,Country)
		VALUES(@ID,@IDValue,@Street,@DoorNumber,@City,@Village,@PinCode,@StateName,@Country)

		INSERT INTO FeeDetails(ID,IDValue,FeeID,FeeToBePaid,FeePaid,FeeDue)
		VALUES(@ID,@IDValue,@FeeID,@FeeToBePaid,@FeePaid,@FeeDue)


	END TRY

		

	BEGIN CATCH
		EXEC FMS_GetErrorInfo
	END CATCH
END







