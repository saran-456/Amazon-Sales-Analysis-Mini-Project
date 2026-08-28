create database sales;
show tables from sales;
use sales;
alter table sales.customers change CustomerID CustomerID varchar(100) unique;
alter table sales.customers change Name Name varchar(100);
alter table sales.customers change City City varchar(50);
select * from sales.customers;
alter table sales.customers change SignupDate SignupDate date;
SET SQL_SAFE_UPDATES = 0;
select * from sales.customers;
alter table sales.order_details change OrderID OrderID varchar(100) unique;
alter table sales.order_details change ProductID ProductID varchar(100);
select * from sales.order_details;
select * from sales.orders;
alter table sales.orders change OrderID OrderID varchar(100) unique;
alter table sales.orders change CustomerID CustomerID varchar(100);
alter table sales.products change ProductID ProductID varchar(100) unique;
alter table sales.products change SupplierID SupplierID varchar(100);
alter table sales.reviews change ReviewID ReviewID varchar(100) unique;
alter table sales.reviews change ProductID ProductID varchar(100);
alter table sales.reviews change CustomerID CustomerID varchar(100);
alter table sales.reviews change Rating Rating tinyint;
select * from sales.suppliers;
alter table sales.suppliers change SupplierID SupplierID varchar(100) unique;
-- task 3
select * from sales.customers where city = 'Port Calebstad';
select * from sales.products where category = "Fruits";
-- task 4
alter table sales.customers change age age int not null;
alter table sales.customers add constraint Age_limit check(age>=18);

create table sales.customer_1(
customer_id int primary key,
name varchar(10) unique,
age int not null check(age>18)
);
-- Task 5

insert into sales.products(ProductID,Productname ,Category,SubCategory,PricePerUnit,StockQuantity,SupplierID) values
("3aabert768-g567-45b5-aa55-8esaodutrebdk",'RuFruits','Fruits','Sub-Fruits-4',200,297,"739703-tyu906473-bfhrt-4fgnhkrpehey"),
("4tyssybvbcsds79gv-hbyvcxtrx-bvcrx8976r",'yuFruits','Fruits','Sub-Fruits-4',205,300,"636939-yigfd864327-afvkife-6gygctdvnki"),
("6r6ftxzrfvjbtrxx-bhcxrsxc46437-bhvg9756",'RFruits','Fruits','Sub-Fruits-4',209,400,"909588-jhuvytt-buyftf-86632459mibuyf");

update sales.products set StockQuantity='201' where ProductID="3aabert768-g567-45b5-aa55-8esaodutrebdk";
select * from sales.suppliers;
 
delete from sales.suppliers where city="Schneidermouth";
-- task 6
alter table sales.reviews add constraint che_rating check(rating between 1 and 5);
alter table sales.customers modify PrimeMember varchar(3) default'No';

-- task 7
alter table sales.orders change OrderDate OrderDate date;
select * from sales.orders where OrderDate>"2024-01-01";
alter table sales.order_details change OrderID OrderID varchar(100) primary key;
alter table sales.orders change OrderID OrderID varchar(100) primary key;
alter table sales.products change ProductID ProductID varchar(100) primary key;
alter table sales.reviews change ReviewID ReviewID varchar(100) primary key;
alter table sales.suppliers change SupplierID SupplierID varchar(100) primary key;
select r.ReviewID,r.ProductID,r.CustomerID,r.rating,r.ReviewText,p.ProductName as Product_name from sales.reviews as r left join sales.products as p on r.ProductID=p.ProductID;
select ProductID,avg(rating) from sales.reviews group by ProductID having avg(rating)>4;
alter table sales.products add column total_sales int;
update sales.products set total_sales = PricePerUnit*StockQuantity;
select ProductName,total_sales from sales.products group by ProductID order by total_sales desc;
-- task 10
SELECT c.CustomerID,c.Name,SUM(o.OrderAmount) AS TotalSpending FROM sales.customers c JOIN sales.orders o ON c.CustomerID = o.CustomerID GROUP BY c.CustomerID,c.Name ORDER BY TotalSpending DESC;
SELECT c.CustomerID,c.Name,SUM(o.OrderAmount) AS TotalSpending,RANK() OVER (ORDER BY SUM(o.OrderAmount) DESC) AS SpendingRank FROM sales.customers c JOIN sales.orders o ON c.CustomerID = o.CustomerID GROUP BY  c.CustomerID, c.Name ORDER BY SpendingRank;
SELECT c.CustomerID,c.Name,SUM(o.OrderAmount) AS TotalSpending FROM sales.customers c JOIN sales.orders o ON c.CustomerID = o.CustomerID GROUP BY  c.CustomerID, c.Name HAVING SUM(o.OrderAmount) > 5000 ORDER BY TotalSpending DESC;
select * from sales.orders;
select * from sales.products;
-- task 11
SELECT o.OrderID,SUM(od.Quantity * od.UnitPrice - od.Discount) AS TotalRevenue FROM sales.orders o JOIN sales.order_details od ON o.OrderID = od.OrderID GROUP BY o.OrderID ORDER BY TotalRevenue DESC;
SELECT c.CustomerID,c.Name,count(o.OrderID) as Total_revenue from sales.customers as c join sales.orders as o on c.CustomerID=o.CustomerID where OrderDate between '2025-01-01' and '2025-01-08' group by c.CustomerID,c.Name Order by Total_revenue desc; 
SELECT s.SupplierID,s.SupplierName,COUNT(p.ProductID) AS ProductsInStock FROM sales.suppliers s join sales.products p ON s.SupplierID = p.SupplierID WHERE p.StockQuantity > 0 GROUP BY  s.SupplierID,s.SupplierName ORDER BY ProductsInStock DESC;
-- task 13
SELECT p.ProductID,p.ProductName,x.TotalRevenue FROM sales.products p JOIN (SELECT ProductID, SUM(Quantity * UnitPrice) AS TotalRevenue FROM sales.order_details GROUP BY ProductID ORDER BY TotalRevenue DESC LIMIT 3
) x ON p.ProductID = x.ProductID ORDER BY x.TotalRevenue DESC;
SELECT CustomerID,Name FROM sales.customers WHERE CustomerID NOT IN (SELECT CustomerID FROM sales.orders);
-- task 14
select * from sales.customers;
select city from sales.customers where PrimeMember ='Yes' group by city order by count(PrimeMember) desc limit 1; 
select Category from sales.products group by Category order by count(ProductID) desc limit 3;
-- task 12
create table sales.categories (CategoryID INT PRIMARY KEY ,CategoryName VARCHAR(100) NOT NULL);
create table sales.subcategories (SubCategoryID INT PRIMARY KEY,SubCategoryName VARCHAR(100) NOT NULL,CategoryID INT NOT NULL, FOREIGN KEY (CategoryID) REFERENCES sales.categories(CategoryID));
alter table sales.products ADD COLUMN CategoryID INT,ADD COLUMN SubCategoryID INT;
alter table sales.products ADD CONSTRAINT fk_product_category FOREIGN KEY (CategoryID) REFERENCES sales.categories(CategoryID);
alter table sales.products ADD CONSTRAINT fk_product_subcategory FOREIGN KEY (SubCategoryID) REFERENCES sales.subcategories(SubCategoryID);
select * from sales.products;
 













