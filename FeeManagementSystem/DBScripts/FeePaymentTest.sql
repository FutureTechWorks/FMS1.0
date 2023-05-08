USE FMS



EXEC FMS_FeePayment @ID='1701',@PayFee = 1000
select * from FeeDetailsHistory order by FeePaidDate desc
select * from FeeDetails

select * from ErrorDetails

ALTER TABLE FeeDetails
ADD CONSTRAINT FeePaid CHECK(FeePaid<=FeeToBePaid)

ALTER TABLE FeeDetails
ADD CONSTRAINT FeeDue CHECK(FeeDue>=0)

ALTER TABLE FeeDetailsHistory
ADD CONSTRAINT AmmountPaid CHECK(AmmountPaid<=FeeToBePaid)

