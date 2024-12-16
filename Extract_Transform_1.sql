-- Assignment 6.1
-- Group 4
-- DATA620 Goerge Cross


-- EXTRACT with partial TRANSFORM
USE candy;
DROP TABLE IF EXISTS orders_bu;
	CREATE TABLE orders_bu
		(
			OrID INT NOT NULL AUTO_INCREMENT,
			OrMonth INT(2) NULL,
			Country VARCHAR(3) NULL,
			Region VARCHAR(10) NULL,
            Product VARCHAR(25) NULL,
			PerUPrice DECIMAL (10,2) NULL,
			Quantity INT NULL,
			OrTotal DECIMAL (15,2) NULL,
            OrDiscount DECIMAL(10,2) NULL,
            OrYear INT(4) NULL,
			PRIMARY KEY (OrID)
		);



LOAD DATA LOCAL INFILE 'C:/Users/rofoche/Documents/DATA620/Week6/2017_data.csv'
INTO table orders_bu
fields terminated by ','
lines terminated by '\r\n' 
ignore 1 rows 
(@OrID
,OrMonth
,Country
,Region
,@State
,Product
,@PerUPrice
,Quantity
,@OrTotal)
SET PerUPrice = @PerUPrice / 100
, OrTotal = Quantity * PerUPrice
, OrDiscount = 0
, OrYear = 2017;

ALTER TABLE orders_bu AUTO_INCREMENT=501;

LOAD DATA LOCAL INFILE 'C:/Users/rofoche/Documents/DATA620/Week6/2018_data.csv'
INTO table orders_bu
fields terminated by ','
lines terminated by '\r\n' 
ignore 1 rows 
(@OrID
,@Months
,@Region
,@Customer
,@Product
,@PerUPrice
,@Quantity_1
, @Quantity_2)
SET OrMonth = @Months
, Country = 'USA'
, Region = @Region
, Product = @Product
, PerUPrice = @PerUPrice / 100
, Quantity = (@Quantity_1 + @Quantity_2)
, OrTotal = (PerUPrice * (Quantity))
, OrDiscount = 0
,OrYear = 2018;

ALTER TABLE orders_bu AUTO_INCREMENT = 1000;

LOAD DATA LOCAL INFILE 'C:/Users/rofoche/Documents/DATA620/Week6/2019_data.csv'
INTO table orders_bu
fields terminated by ','
lines terminated by '\r\n' 
ignore 1 rows
(@OrID
,OrMonth
,@Country
,@Region
,@State
,@Product
,@PerUPrice
,@Quantity
,@OrSub
,@OrDiscount)
SET Country = @Country
,Region = @Region
,Product = @Product
,PerUPrice = @PerUPrice / 100
,Quantity = @Quantity
,OrTotal = ((PerUPrice * @Quantity) - (@OrDiscount / 100)) 
,OrDiscount = @OrDiscount / 100
,OrYear = 2019;

-- TRANSFORM
DROP TABLE IF EXISTS prod_order_bu;
	CREATE TABLE prod_order_bu
		(
			PO_OrID INT NOT NULL, 
			PO_Prod_BU_ID INT NOT NULL
		);

INSERT INTO prod_order_bu (PO_OrID,PO_Prod_BU_ID)
SELECT O.OrID, P.Prod_BU_ID
FROM orders_bu O, product_bu P
WHERE O.OrYear = P.Prod_BU_Year;

ALTER TABLE prod_order_bu
ADD CONSTRAINT PK_prod_order_bu PRIMARY KEY (PO_OrID,PO_Prod_BU_ID),
ADD CONSTRAINT FK_orders_prod_order FOREIGN KEY (PO_OrID) REFERENCES orders_bu(OrID),
ADD CONSTRAINT FK_product_bu_prod_order FOREIGN KEY (PO_Prod_BU_ID) REFERENCES product_bu(Prod_BU_ID);

DROP TABLE IF EXISTS product_desc_bu;
	CREATE TABLE product_desc_bu
    (
		product_desc_BU_ID INT NOT NULL, 
		product_desc_Prod_BU_ID INT NOT NULL
    );

INSERT INTO product_desc_bu (product_desc_BU_ID,product_desc_Prod_BU_ID)
SELECT B.BU_ID, P.Prod_BU_ID
FROM business_unit B, product_bu P
WHERE B.BU_Name = P.BU_Name;

ALTER TABLE product_desc_bu
ADD CONSTRAINT PK_product_desciption_bu PRIMARY KEY (product_desc_BU_ID,product_desc_Prod_BU_ID),
ADD CONSTRAINT FK_BU_product_desc FOREIGN KEY (product_desc_BU_ID) REFERENCES business_unit(BU_ID),
ADD CONSTRAINT FK_Product_product_desc FOREIGN KEY (product_desc_Prod_BU_ID) REFERENCES product_bu(Prod_BU_ID);


