SELECT * FROM saleswalmart.sales1;

CREATE DATABASE IF NOT EXISTS SALESWALMART1;

CREATE TABLE IF NOT EXISTS SALES(
    INVOICE_ID VARCHAR(30) NOT NULL PRIMARY KEY,
    BRANCH VARCHAR(5) NOT NULL,
    CITY VARCHAR(30) NOT NULL,
    CUSTOMER_TYPE VARCHAR(30) NOT NULL,
    GENDER VARCHAR(10) NOT NULL,
    PRODUCT_LINE VARCHAR(100) NOT NULL,
    UNIT_PRICE DECIMAL(10,2) NOT NULL,
    QUANTITY INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    TOTAL DECIMAL(12,4) NOT NULL,
    DATE DATETIME NOT NULL,
    TIME TIME NOT NULL,
    PAYMENT_METHOD VARCHAR(15) NOT NULL,
    COGS DECIMAL(10,2) NOT NULL,
    GROSS_MARGIN_PCT FLOAT(11,9),
    GROSS_INCOME DECIMAL(12,4) NOT NULL,
    RATING FLOAT(2,1)
);



-- ------------------------------------------------------------------------------
-- --Feature engineering----------

-- time_of_day

SELECT TIME FROM SALES;



-- ------------------------------------------------------------------------------
-- --Feature engineering----------

-- time_of_day

SELECT TIME,
(CASE
WHEN 'TIME' BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
WHEN 'TIME' BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
ELSE "Evening"
END
) AS TIME_OF_DATE
FROM SALES1;

alter table sales1
drop column time_of_day;

ALTER TABLE SALES1 ADD COLUMN TIME_OF_DAY VARCHAR(20);

UPDATE SALES1 
SET TIME_of_day = (CASE
WHEN TIME BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
WHEN TIME BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
ELSE "Evening"
END
); 

-- ------DAY_NAME-----

SELECT 
DATE,
DAYNAME(DATE)
FROM SALES1;

ALTER TABLE SALES1
ADD COLUMN DAY_NAME VARCHAR (10);

UPDATE sales1
SET DAY_NAME= DAYNAME(DATE);


-- --MONTHNAME

SELECT DATE,
MONTHNAME(DATE)
FROM SALES1;

ALTER TABLE SALES1
ADD COLUMN MONTH_NAME VARCHAR (10);

UPDATE sales1
SET MONTH_NAME= monthname(DATE);

-- ---EDA----
.
--how many unique cities does the data ave?

select distinct city from sales1;

-- -in wich city is each branch

select distinct city, branch from sales1;

-- ----------------------Product ----------

-- -------unique product lines

select distinct product_line , count(distinct product_line) from sales1

-- --common payment emtod---

select payment_method
,count(payment_method) as cnt
from sales1
group by payment_method
order by cnt desc;

-- --wt is the most selling product

select product_line,
count(product_line) as cnt1
from sales1
group by product_line
order by cnt1 desc;

-- -what is te total revenue by month?
select sum(total) as total_revnue, month_name as month
from sales1
group by month_name
order by total_revenue desc;

-- --mont hasd largest cogs??

select month_name as month,
sum(cogs) as cogs
from sales1
group by month_name
order by cogs desc;

-- -product line had largest reveneu

select product_line, sum(total) as total_revenue
from sales1
group by product_line
order by total_revenue

-- city wit largets revenue

select city, sum(total) as total_revenue
from sales1
group by city
order by total_revenue

--wihc PRODUCT_LINE has high VAT

select PRODUCT_LINE, sum(VAT) as total_VAT, AVG(VAT)
from sales1
group by PRODUCT_LINE
order by total_VAT DESC

------ BRANCH SOLD MORE PRODUCT

SELECT BRANCH, SUM(QUANTITY) AS QTY
FROM SALES1
GROUP BY BRANCH
HAVING SUM(QUANTITY) >(SELECT AVG(QUANTITY) FROM SALES1);

--MOST COMMON PRODYCT LINE BY GEMDER

SELECT GENDER,
PRODUCT_LINE, COUNT(GENDER) AS TOTAL_CNT
FROM SALES1
GROUP BY GENDER, PRODUCT_LINE
ORDER BY TOTAL_CNT

-- -AVG RATING FRO PRODUC TLINE

SELECT ROUND(AVG (RATING),2) AS RATING, PRODUCT_LINE
FROM SALES1
GROUP BY PRODUCT_LINE
ORDER BY RATING DESC;

-- --------------------------------------------------------
-- ---Sales------

-- --Number of sales made in each time of the day per weekday--

select time_of_day, count(*) as sales_total
from sales1
where day_name= 'Tuesday'
group by time_of_day
order by sales_total desc;

-- ---------------------------------------------------------------
-- --------types customers bring most revenue--

select CUSTOMER_TYPE, SUM(TOTAL) AS REVENUE
from sales1
GROUP BY CUSTOMER_TYPE
ORDER BY REVENUE DESC;

-- -------------------------------------------------------------
-- --WHICH CITY HAS THE LARGEST TAX PRCNNT, VAT?
SELECT
CITY, SUM(VAT) AS TOTAL_VAT
FROM SALES1
GROUP BY CITY
ORDER BY TOTAL_VAT DESC;

-- ---WIC CUSTOMER TYPE PAYS THE MOST VAT?--

SELECT
CUSTOMER_TYPE, SUM(VAT) AS TOTAL_VAT
FROM SALES1
GROUP BY CUSTOMER_TYPE
ORDER BY TOTAL_VAT DESC;

-- -------------------------------
-- --------CUSTOMER---------

-- --How many unique customer types does the data have?--
SELECT
distinct CUSTOMER_TYPE,COUNT(CUSTOMER_TYPE) AS COUNT
FROM SALES1
GROUP BY CUSTOMER_TYPE;

-- -UNIQUE PAYMENT--

SELECT
distinct PAYMENT_METHOD,COUNT(PAYMENT_METHOD) AS COUNT
FROM SALES1
GROUP BY PAYMENT_METHOD;

-- -TYPE CUSOTMER BUYS THE MOST

SELECT 
CUSTOMER_TYPE,COUNT(CUSTOMER_TYPE) AS CNT
FROM SALES1
GROUP BY CUSTOMER_TYPE;

-- -GENDER OF CUSOTMERS
SELECT 
GENDER, COUNT( GENDER) AS CNT
FROM SALES1
GROUP BY GENDER;

-- -ORDER BY BYDEFAULT REMAIN AESC

-- -GENDER DISTRIBUTION PER BRANCH
SELECT
GENDER ,COUNT(GENDER) AS CNT
FROM SALES1
WHERE BRANCH = 'C'
GROUP BY GENDER
ORDER BY CNT;

-- -TIME OF DAY WNE CUSTOMER GIVES MOST RATING

SELECT
TIME_OF_DAY, AVG(RATING) AS AVGS
FROM SALES1
GROUP BY TIME_OF_DAY
ORDER BY AVGS DESC;


-- -TIME OF DAY WNE CUSTOMER GIVES MOST RATING PER BRACH

SELECT
TIME_OF_DAY, AVG(RATING) AS AVGS
FROM SALES1
WHERE BRANCH = 'C'
GROUP BY TIME_OF_DAY
ORDER BY AVGS DESC;

-- --DAY OF WEEK HAS AVG RATING

SELECT DAY_NAME, AVG(RATING) AVGD
FROM SALES1
GROUP BY DAY_NAME
ORDER BY AVGD DESC;

-- -Which day of the week has the best average ratings per branch?--

SELECT
DAY_NAME, AVG(RATING) AS AVGD
FROM SALES1
WHERE BRANCH = 'C'
GROUP BY DAY_NAME
ORDER BY AVGD DESC;


-- --REVENUE AND PROFIT CALCULATION--

SELECT 
(vat + cogs) as gross_sales
FROM SALES1

SELECT 
sum(
FROM SALES1

Cost of goods sold= price * quantity





