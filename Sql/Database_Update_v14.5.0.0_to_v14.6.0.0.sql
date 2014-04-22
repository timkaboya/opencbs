IF  NOT EXISTS(SELECT *  FROM  INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Roles'  AND COLUMN_NAME = 'role_of_loan' AND COLUMN_NAME = 'role_of_saving' AND COLUMN_NAME = 'role_of_teller') 
BEGIN
DECLARE @Str NVARCHAR(100)
SET @Str = ( SELECT   name
               FROM     sysobjects
               WHERE    name LIKE 'DF__Roles__role_of_l%'
             )
EXEC('ALTER TABLE Roles DROP CONSTRAINT '+ @Str)

SET @Str = ( SELECT   name
               FROM     sysobjects
               WHERE    name LIKE 'DF__Roles__role_of_s%'
             )
EXEC('ALTER TABLE Roles DROP CONSTRAINT '+ @Str)

SET @Str = ( SELECT   name
               FROM     sysobjects
               WHERE    name LIKE 'DF__Roles__role_of_t%'
             )
EXEC('ALTER TABLE Roles DROP CONSTRAINT '+ @Str)
 
ALTER TABLE  Roles DROP COLUMN  role_of_loan
ALTER TABLE  Roles DROP COLUMN  role_of_saving
ALTER TABLE  Roles DROP COLUMN  role_of_teller
END
GO
 
DELETE FROM dbo.GeneralParameters WHERE [KEY] ='CITY_IS_AN_OPEN_VALUE'
GO

DELETE FROM dbo.GeneralParameters WHERE [KEY] ='NAME_FORMAT'
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InstallmentsTemp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InstallmentHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contract_id] [int] NOT NULL,
	[event_id] [int] NOT NULL,
	[number] [int] NOT NULL,
	[expected_date] [datetime] NOT NULL,
	[capital_repayment] [money] NOT NULL,
	[interest_repayment] [money] NOT NULL,
	[paid_interest] [money] NOT NULL DEFAULT ((0)),
	[paid_capital] [money] NOT NULL DEFAULT ((0)),
	[paid_fees] [money] NOT NULL DEFAULT ((0)),
	[fees_unpaid] [money] NOT NULL DEFAULT ((0)),
	[paid_date] [datetime] NULL,
	[delete_date] [datetime] NULL,
	[comment] [nvarchar](50) NULL,
	[pending] [bit] NOT NULL DEFAULT ((0)),
	[start_date] [datetime] NOT NULL DEFAULT (getdate()),
	[olb] [money] NOT NULL DEFAULT ((0))
) ON [PRIMARY]
END
GO
 
UPDATE  [TechnicalParameters]
SET     [value] = 'v14.6.0.0'
WHERE   [name] = 'VERSION'
GO
  