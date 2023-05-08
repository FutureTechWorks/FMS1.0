USE FMS

EXEC FMS_InsertStudentDetails
@ID = '1704',
@StudentName = 'Varshini',
@Class = 'Tenth Class',
@Section ='A',
@DateOfJoining = '20-04-2023',
@FatherName = 'Raj Kumar' ,
@MotherName = 'Lasya',
@GuardianName = NULL,
@MobileNumber = '9900272926',
@AlternateMobileNumber = '7469693008',
@DateOfBirth = '24-10-1998',
@Street = 'Bharath pet',
@DoorNumber = '9-20-198/1',
@City = 'Guntur',
@Village = NULL,
@PinCode = '522002',
@StateName = 'Andhra Pradesh',
@Country = 'INDIA',
@FeeToBePaid = 25000,
@FeePaid = NULL,
@FeeDue  = NULL

select * from StudentDetails
select * from PersonalDetails
select * from AddressDetails
select * from FeeDetails


