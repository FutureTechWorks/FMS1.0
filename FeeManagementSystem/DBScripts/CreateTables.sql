USE [FMS]
GO
/****** Object:  StoredProcedure [dbo].[FMS_CreateTables]    Script Date: 22-04-2023 16:54:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FMS_CreateTables]
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		
		CREATE TABLE ClassDetails (
			Class NVARCHAR(100) NOT NULL UNIQUE,
			ClassValue NVARCHAR(100),
			PRIMARY KEY(ClassValue)
		)

		CREATE TABLE SectionDetails (
			Section NVARCHAR(100) NOT NULL UNIQUE,
			SectionValue NVARCHAR(100),
			PRIMARY KEY(SectionValue)
		)

		CREATE TABLE StudentDetails (
			ID NVARCHAR(100) NOT NULL UNIQUE,
			IDValue NVARCHAR(100),
			StudentName NVARCHAR(100) NOT NULL,
			StudentNameValue NVARCHAR(100) NOT NULL,
			Class NVARCHAR(100) NOT NULL,
			ClassValue NVARCHAR(100) NOT NULL,
			Section NVARCHAR(100) NOT NULL,
			SectionValue NVARCHAR(100) NOT NULL,
			DateOfJoining DATE,
			PRIMARY KEY(IDValue),
			FOREIGN KEY(ClassValue) REFERENCES ClassDetails(ClassValue),
			FOREIGN KEY(SectionValue) REFERENCES SectionDetails(SectionValue)

		)

		CREATE TABLE PersonalDetails (
			ID	NVARCHAR(100) NOT NULL,
			IDValue NVARCHAR(100) NOT NULL,
			FatherName NVARCHAR(100),
			MotherName NVARCHAR(100),
			GuardianName NVARCHAR(100),
			MobileNumber NVARCHAR(100),
			AlternateMobileNumber NVARCHAR(100),
			DateOfBirth Date,
			FOREIGN KEY(IDValue) REFERENCES StudentDetails(IDValue)
		)

		CREATE TABLE AddressDetails (
			ID	NVARCHAR(100) NOT NULL,
			IDValue NVARCHAR(100) NOT NULL,
			Street NVARCHAR(100),
			DoorNumber NVARCHAR(100),
			City NVARCHAR(100),
			Village NVARCHAR(100),
			PinCode NVARCHAR(100),
			StateName NVARCHAR(100),
			Country NVARCHAR(100) DEFAULT 'INDIA',
			FOREIGN KEY(IDValue) REFERENCES StudentDetails(IDValue)
		)

		CREATE TABLE FeeDetails (
			ID	NVARCHAR(100) NOT NULL,
			IDValue NVARCHAR(100) NOT NULL,
			FeeID NVARCHAR(100),
			FeeToBePaid INT NOT NULL,
			FeePaid INT NOT NULL,
			FeeDue INT NOT NULL,
			PRIMARY KEY(FeeID),
			FOREIGN KEY(IDValue) REFERENCES StudentDetails(IDValue)
		)

		CREATE TABLE FeeDetailsHistory (
			ID	NVARCHAR(100) NOT NULL,
			IDValue NVARCHAR(100) NOT NULL,
			FeeID NVARCHAR(100),
			FeeToBePaid INT NOT NULL,
			AmmountPaid INT NOT NULL,
			FeePaid INT NOT NULL,
			FeeDue INT NOT NULL,
			FeePaidDate DateTime NOT NULL,
			FOREIGN KEY(IDValue) REFERENCES StudentDetails(IDValue),
			FOREIGN KEY(FeeID) REFERENCES FeeDetails(FeeID)
		)
		
		CREATE TABLE ErrorDetails( 
			ErrorNumber INT,
			ErrorMessage NVARCHAR(4000),
			ErrorSeverity INT,
			ErrorState INT,
			ErrorProcedure NVARCHAR(200),
			ErrorLine INT,
			CreatedOn DATE
		)
			
	END TRY

	BEGIN CATCH
		EXEC FMS_GetErrorInfo
	END CATCH
END












