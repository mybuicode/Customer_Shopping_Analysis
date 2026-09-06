/*During data ingestion, the Review_Ratings field was incorrectly parsed by SQL Server's Flat File Wizard, 
causing decimal values to lose their decimal separator.
The field was re-imported with an appropriate decimal data type and validated against the source CSV
*/
--UPDATE shopping_trends_updated
--SET Review_Rating = Review_Rating / 10.0;

SELECT TOP 20 Review_Rating
FROM shopping_trends_updated;

--Detecting Duplicates
SELECT *
FROM (
    SELECT Customer_ID,Age,Gender,count(*) as records
    FROM shopping_trends_updated
    GROUP BY Customer_ID,Age,Gender
) a 
WHERE records > 1
-- No duplicate

--1.See how many customer
SELECT COUNT(DISTINCT Customer_ID) as total_customer FROM shopping_trends_updated;
--We have a total of 3900

--2.The % of customers male vs female
SELECT Gender,
    COUNT(DISTINCT Customer_ID) AS Number,
    COUNT(DISTINCT Customer_ID) *100/ SUM(COUNT(DISTINCT Customer_ID)) OVER () AS Percentage
FROM shopping_trends_updated
GROUP BY Gender;
--The customer base is predominantly male, accounting for 68% of customers, while females represent 32%

--3.What are the most purchased categories and items by season?
WITH ranked_items AS (
SELECT Season,Item_Purchased,COUNT(*) AS Purchase_Count,
        DENSE_RANK() OVER (PARTITION BY Season ORDER BY COUNT(*) DESC ) AS Ranking
    FROM shopping_trends_updated
    GROUP BY Season, Item_Purchased
)
SELECT *
FROM ranked_items
WHERE Ranking <= 5
ORDER BY Season, Ranking;
--Spring Sweater,Shorts. Coat, Blouse,Skirt
--Summer Pants, followed by Jewelry and Dress
-- Fall Jacket, followed by Hat and Handbag
--Winter Sunglasses, followed by Pants and Shirt
/*Product demand varies significantly by season, suggesting that inventory planning should account for seasonal purchasing patterns */

--4. What are the most popular color by season?
WITH ranked_color AS (
SELECT Season,Color,COUNT(*) AS Purchase_Count,
        DENSE_RANK() OVER (PARTITION BY Season ORDER BY COUNT(*) DESC ) AS Ranking
    FROM shopping_trends_updated
    GROUP BY Season, Color
)
SELECT *
FROM ranked_color
WHERE Ranking <= 5
ORDER BY Season, Ranking;
--Spring: Olive, followed by Gray and Teal
--Summer: Silver, followed by Teal and Blue
--Fall:Magenta and Yellow, followed by Olive
--Winter:Green, followed by Yellow and Pink
/*Customer color preferences vary across seasons, 
providing an additional dimension for seasonal merchandising and product assortment decisions. */

--5. Should stocking strategies vary by store location?
WITH item_by_location AS (
    SELECT Location,Item_Purchased,COUNT(*) AS purchase_count
    FROM shopping_trends_updated
    GROUP BY Location, Item_Purchased
),ranked_items AS (
    SELECT Location,Item_Purchased,purchase_count,DENSE_RANK() OVER (
            PARTITION BY Location
            ORDER BY purchase_count DESC
        ) AS ranking
    FROM item_by_location
)
SELECT *
FROM ranked_items
WHERE ranking <= 3
ORDER BY Location, ranking;
--Product preferences vary across locations, suggesting that inventory allocation could be localized based on regional demand patterns.

--6.Which loaction are top-performing in terms of customer experience?
SELECT Location,ROUND(AVG(Review_Rating),2) as avg_rating
FROM shopping_trends_updated
GROUP BY Location
ORDER BY 2 DESC;
/*Michigan and New Jersey have the highest average customer ratings,
making them potential benchmarks for further investigation into customer experience practices */

--7.Do customers with more than 10 previous purchases spend more per transaction
SELECT CASE
        WHEN Previous_Purchases > 10 THEN 'More than 10'
        ELSE '10 or less'
    END AS previous_purchase_status,
    COUNT(*) AS number_of_customers,
    AVG(Purchase_Amount_USD) AS avg_spend
FROM shopping_trends_updated
GROUP BY CASE
        WHEN Previous_Purchases > 10 THEN 'More than 10'
        ELSE '10 or less' END;
/*Customers with more than 10 previous purchases do not appear to spend more per purchase.
Their average purchase amount ($59) is slightly lower than customers with 10 or fewer previous purchases ($60), 
suggesting that purchase frequency alone is not strongly associated with higher spending per transaction.
*/

--8. Which product categories generate the highest revenue?
SELECT Category,SUM(Purchase_Amount_USD) as Revenue
FROM shopping_trends_updated
GROUP BY Category
ORDER BY 2 DESC;
/*Clothing generates the highest revenue among all product categories, making it a key revenue-driving category.
The business should prioritize inventory availability and product assortment within the Clothing category.
*/

--9.Do subscribed customers spend more than non-subscribed customers?
SELECT Subscription_Status,COUNT(Subscription_Status) as Number, AVG(Purchase_Amount_USD) as Avg_Spend
FROM shopping_trends_updated
GROUP BY Subscription_Status;
--Although non-subscribed customers significantly outnumber subscribed customers, the average purchase amount is similar between the two groups.
/*Subscription status does not appear to be strongly associated with higher transaction value. 
Further analysis is needed to determine whether subscriptions improve other metrics such as purchase frequency or customer retentio
*/

--10. Does applying a discount affect purchase amount?
SELECT Discount_Applied,COUNT(Discount_Applied) as Number, AVG(Purchase_Amount_USD) as Avg_Spend
FROM shopping_trends_updated
GROUP BY Discount_Applied;
--Customers without discounts have a slightly higher average purchase amount than customers who received discounts
/*Discounts do not appear to increase average transaction value in this dataset.
The business should further evaluate whether discounts drive other outcomes, such as purchase frequency or customer acquisition.
*/

--11.Which location generate the highest revenue?
WITH revenue_location as(
SELECT Location,COUNT(*) AS Purchase_Count,
    SUM(Purchase_Amount_USD) as total_revenue,
ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Purchase
FROM shopping_trends_updated
GROUP BY Location)

SELECT Location,Purchase_Count,
    total_revenue,DENSE_RANK() OVER (ORDER BY total_revenue DESC) as Rank_revenue,
    Avg_Purchase,DENSE_RANK() OVER (ORDER BY Avg_Purchase DESC) as Rank_avg
FROM revenue_location
ORDER BY total_revenue DESC;
--Montana generates the highest total revenue ($5,784),while its average purchase value ranks only 6th at $60.
/*This suggests that Montana's strong revenue performance may be driven more by purchase volume than by higher transaction value.*/

DROP VIEW IF EXISTS vw_Top3_Items_By_Location;
GO
CREATE VIEW vw_Top3_Items_By_Location AS

WITH item_by_location AS (
    SELECT Location,Item_Purchased,COUNT(*) AS Purchase_Count
    FROM shopping_trends_updated
    GROUP BY Location, Item_Purchased
),
ranked_items AS (
    SELECT Location,Item_Purchased,Purchase_Count,
        DENSE_RANK() OVER ( PARTITION BY Location ORDER BY Purchase_Count DESC) AS Ranking
    FROM item_by_location)
SELECT *
FROM ranked_items
WHERE Ranking <= 3;