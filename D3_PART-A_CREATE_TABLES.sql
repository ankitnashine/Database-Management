CREATE SCHEMA `X_Credit_Union` ;

USE X_Credit_Union;


CREATE TABLE MEMBERS (
ClientID Int NOT NULL,
First_Name Varchar(40) NOT NULL,
Last_Name Varchar(40) NOT NULL,
Social_Security_Number int NOT NULL,
Email_Address Varchar(40) NULL,
Phone_Number Char(10) NULL,
Address Varchar(60) NULL,

CONSTRAINT MembersPK PRIMARY KEY(ClientID),
CONSTRAINT Social_Security_NumberAK1 UNIQUE(Social_Security_Number),
CONSTRAINT Email_AddressAK2 UNIQUE(Email_Address),
CONSTRAINT Phone_NumberAK3 UNIQUE(Phone_Number));

CREATE TABLE ACCOUNTS (
Account_Number Int NOT NULL,
Type_of_accounts char(10) NOT NULL,
Primary_Owner Varchar(100) NOT NULL,
Number_of_Owners int NOT NULL,
Current_Balance decimal(50,10) NOT NULL,

CONSTRAINT AccountsPK PRIMARY KEY(Account_Number));

CREATE TABLE JOINT_ACCOUNTS (
ClientID Int NOT NULL,
Account_Number Int NOT NULL,

CONSTRAINT Joint_AccountsPK PRIMARY KEY(ClientID,Account_Number),
CONSTRAINT ClientIDFK FOREIGN KEY(ClientID)
REFERENCES MEMBERS(ClientID)
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE MESSAGE_TABLE (
Message_ID Int NOT NULL,
ClientID Int NOT NULL,
Messages Varchar(1000) NOT NULL,

CONSTRAINT Message_TablePK PRIMARY KEY(Message_ID),
CONSTRAINT MT_ClientIDFK FOREIGN KEY(ClientID)
REFERENCES MEMBERS(ClientID)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE RATE_TABLE (
Type_of_Account Char (10) NOT NULL,
Current_Interest_Rate DECIMAL(8,5) NOT NULL,

CONSTRAINT Rate_TablePK PRIMARY KEY(Type_of_Account));

CREATE TABLE CHECKING (
Account_Number INT NOT NULL,
Current_Interest_Rate DECIMAL(8,5) NOT NULL,
Last_Interest_Date Varchar(10) NULL,
Minimal_Balance_Requirement DECIMAL(50,10) NOT NULL,

CONSTRAINT CheckingPK PRIMARY KEY(Account_Number),
CONSTRAINT C_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE SAVINGS (
Account_Number INT NOT NULL,
Current_Interest_Rate DECIMAL(8,5) NOT NULL,
Last_Interest_Date Varchar(10) NULL,
Minimal_Balance_Requirement DECIMAL(50,10) NOT NULL,

CONSTRAINT SavingsPK PRIMARY KEY(Account_Number),
CONSTRAINT S_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE CD (
Account_Number INT NOT NULL,
Last_Interest_Date Varchar(10) NULL,
Term DECIMAL(8,5) NOT NULL,
Interest_Rate DECIMAL(8,5) NOT NULL,

CONSTRAINT CD_PK PRIMARY KEY(Account_Number),
CONSTRAINT CD_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE DAILY_BALANCE (
Account_Number INT NOT NULL,
Date Varchar(10) NOT NULL,
End_Day_Balance DECIMAL(50,10) NOT NULL,

CONSTRAINT DB_PK PRIMARY KEY(Account_Number),
CONSTRAINT DB_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE LOAN (
Account_Number INT NOT NULL,
Type_of_Loans char (40) NOT NULL,
Principle DECIMAL(50,10) NOT NULL,
Term DECIMAL(8,5) NOT NULL,
Monthly_Payment DECIMAL(10,5) NOT NULL,
Interest_Rate DECIMAL(8,5) NOT NULL,
Amount_Due DECIMAL(50,10) NOT NULL,
Payment_Received_in_Last_Month DECIMAL(50,10) NULL,
Next_Payment_Due_Date Varchar(10) NOT NULL,
Next_Payment_Due_Amount DECIMAL(50,10) NULL,
Termination_Date Varchar(10) NOT NULL,
Account_Status Char (10) NOT NULL,

CONSTRAINT Loan_PK PRIMARY KEY(Account_Number),
CONSTRAINT Loan_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE TRANSACTION_TABLE (
Transaction_Number INT NOT NULL,
Transaction_Date_and_Time Varchar(20) NOT NULL,
Type_of_Transaction Char (20) NOT NULL,

CONSTRAINT TB_PK PRIMARY KEY(Transaction_Number));

CREATE TABLE PAYMENT (
Transaction_Number INT NOT NULL,
Account_Number INT NOT NULL,
Transaction_Date_and_Time Varchar(20) NOT NULL,
Sender Char (30)  NULL,
Receiver Char (30) NOT NULL,
Type_of_Account Char (10) NOT NULL,
Mode_of_Payment Char (20) NOT NULL,
Amount DECIMAL(50,10) NOT NULL,

CONSTRAINT Payment_PK PRIMARY KEY(Transaction_Number),
CONSTRAINT Payment_Transaction_NumberFK FOREIGN KEY(Transaction_Number)
REFERENCES TRANSACTION_TABLE(Transaction_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT Payment_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE WITHDRAWAL (
Transaction_Number INT NOT NULL,
Account_Number INT NOT NULL,
Transaction_Date_and_Time Varchar(20) NOT NULL,
Type_of_Account Char (10) NOT NULL,
Authorized_Party_Info Varchar(60) NOT NULL,
Amount DECIMAL(50,10) NOT NULL,

CONSTRAINT W_PK PRIMARY KEY(Transaction_Number),
CONSTRAINT W_Transaction_NumberFK FOREIGN KEY(Transaction_Number)
REFERENCES TRANSACTION_TABLE(Transaction_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT W_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);

CREATE TABLE DEPOSIT (
Transaction_Number INT NOT NULL,
Account_Number INT NOT NULL,
Transaction_Date_and_Time Varchar(20) NOT NULL,
Type_of_Account Char (10) NOT NULL,
Amount DECIMAL(50,10) NOT NULL,
Mode_of_Deposit Varchar(20) NOT NULL,

CONSTRAINT D_PK PRIMARY KEY(Transaction_Number),
CONSTRAINT D_Transaction_NumberFK FOREIGN KEY(Transaction_Number)
REFERENCES TRANSACTION_TABLE(Transaction_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT D_Account_NumberFK FOREIGN KEY(Account_Number)
REFERENCES ACCOUNTS(Account_Number)
ON UPDATE NO ACTION
ON DELETE NO ACTION);