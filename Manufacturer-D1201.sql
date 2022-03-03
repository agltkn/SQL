CREATE DATABASE Manufacturer;

USE Manufacturer;

CREATE TABLE Product(
	prod_id int PRIMARY KEY NOT NULL,
	prod_name varchar(50) NULL,
	quantity int NULL
	);

CREATE TABLE Supplier(
	supp_id int PRIMARY KEY NOT NULL,
	supp_name varchar(50) NULL,
	supp_location varchar(50) NULL,
	supp_country varchar(50) NULL,
	is_active bit NULL
	);

CREATE TABLE Component(
	comp_id int PRIMARY KEY NOT NULL,
	comp_name varchar(50) NULL,
	[description] varchar(50) NULL,
	quantity_comp int NULL
	);

CREATE TABLE Prod_Comp(
	prod_id int NOT NULL,
	comp_id int NOT NULL,
	quantity_comp int,
	PRIMARY KEY (prod_id, comp_id)
	);

CREATE TABLE Comp_Supp(
	supp_id int NOT NULL,
	comp_id int NOT NULL,
	order_date date NULL,
	quantity int NULL,
	PRIMARY KEY(supp_id,comp_id)
	);

ALTER TABLE Prod_Comp
ADD CONSTRAINT FK_prod_id
FOREIGN KEY (prod_id)
REFERENCES Product (prod_id)

ALTER TABLE Prod_Comp
ADD CONSTRAINT FK_comp_id
FOREIGN KEY (comp_id)
REFERENCES Component (comp_id)

ALTER TABLE Comp_Supp
ADD CONSTRAINT FK_supp_id
FOREIGN KEY (supp_id)
REFERENCES Supplier (supp_id)

ALTER TABLE Comp_Supp
ADD CONSTRAINT FK_comp_id2
FOREIGN KEY (comp_id)
REFERENCES Component (comp_id)

