USE [FMS]
GO
/****** Object:  StoredProcedure [dbo].[FMS_GetErrorInfo]    Script Date: 22-04-2023 17:07:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FMS_GetErrorInfo]
AS
BEGIN
    DECLARE @error_number int
    DECLARE @error_message nvarchar(4000)
    DECLARE @error_severity int
    DECLARE @error_state int
    DECLARE @error_procedure nvarchar(200)
    DECLARE @error_line int

    
    SELECT @error_number = ERROR_NUMBER(),
           @error_message = ERROR_MESSAGE(),
           @error_severity = ERROR_SEVERITY(),
           @error_state = ERROR_STATE(),
           @error_procedure = ERROR_PROCEDURE(),
           @error_line = ERROR_LINE()
    
	INSERT INTO ErrorDetails VALUES(
		@error_number,
		@error_message,
        @error_severity,
        @error_state,
        @error_procedure,
        @error_line,
		GETDATE()
	)

	SELECT  ErrorNumber = @error_number,
            ErrorMessage = @error_message,
            ErrorSeverity = @error_severity,
            ErrorState = @error_state,
            ErrorProcedure = @error_procedure,
            ErrorLine = @error_line
END
