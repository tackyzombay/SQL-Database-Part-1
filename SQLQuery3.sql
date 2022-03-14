create database ReturnLoanBook

use [ReturnLoanBook]

create table Member(
	MID varchar(7) primary key check(MID like 'G[0-9][0-9][0-9][0-9][0-9][0-9]'),
	IDCardNum varchar(13) not null check(IDCardNum like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	MName varchar(50) not null,
	MAddress varchar(50) not null,
	MDOB date,
	MPhone varchar(50) not null,
	MType varchar(50) not null
)

create table Operator(
	OpID varchar(4) primary key check(OpID like 'OP[0-9][0-9]'),
	OpName varchar(50) not null,
	Staff varchar(50) not null
)

create table DetailTransaksi(
	BookID varchar(10) primary key check(BookID like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Quantity int not null,
	AudioBook varchar(50) not null,
	BookCondition varchar(50) not null,
	Loan float not null,
	Fine float not null
)

create table HeaderTransaksi(
	primary key(BookID),
	BookID varchar(10) foreign key references DetailTransaksi(BookID) on update cascade on delete cascade,
	MID varchar(7) foreign key references Member(MID) on update cascade on delete cascade,
	OpID varchar(4) foreign key references Operator(OpID) on update cascade on delete cascade,
	LDate date,
	RDate date,
	RDay varchar(50) not null
)

create table Book(
	ProductID varchar(10) constraint physical primary key check(ProductID like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	BookID varchar(10) foreign key references DetailTransaksi(BookID) on update cascade on delete cascade,
	BookTitle varchar(50) not null,
	Edition varchar(50) not null
)


alter table Book
drop constraint physical

alter table Book
add constraint physical check(BookID like 'PBV[0-9][0-9][0-9][0-9]')
