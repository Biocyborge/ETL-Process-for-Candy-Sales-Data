-- Assignment 6.1
-- Ralu Ofoche
-- DATA620 Goerge Cross

USE candy;
SELECT  B.BU_Designation AS 'BU Designation',',',
		B.BU_Name AS 'BU Name' ,',',
        P.Product_Name AS 'Product',',',
        O.Region, ',',
        P.Prod_BU_Year AS 'Year',',',
        O.OrMonth AS 'Month',',',
        SUM(O.Quantity) AS 'Sum of Quantity',',',
        SUM(O.OrTotal) AS 'Sum of OrderTotal'
FROM 
	business_unit B JOIN product_desc_bu D
	ON D.product_desc_BU_ID = B.BU_ID
    JOIN product_bu P 
    ON D.product_desc_Prod_BU_ID = P.Prod_BU_ID
    JOIN prod_order_bu R
    ON P.Prod_BU_ID = R.PO_Prod_BU_ID
    JOIN orders_bu O
    ON R.PO_OrID = O.OrID
    WHERE B.BU_Designation IN ('Growth','Mature')
    GROUP BY B.BU_Designation, 
			 B.BU_Name, 
             P.Product_Name,
             O.Region, 
             P.Prod_BU_Year, 
             O.OrMonth
	ORDER BY B.BU_Designation, 
			 B.BU_Name,
             P.Product_Name,
             O.Region,
             P.Prod_BU_Year,
             O.OrMonth,
             SUM(O.Quantity),
             SUM(O.OrTotal);
