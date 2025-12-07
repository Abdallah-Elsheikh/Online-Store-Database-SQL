-- 1. Create Tables (Schema)
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    StockQuantity INT DEFAULT 0,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Cart_Items (
    CartItemID INT PRIMARY KEY,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE OrderTable (
    OrderID INT PRIMARY KEY,
    OrderDate DATE, 
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    OrderID INT UNIQUE,
    FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID)
);

-- 2. Insert Dummy Data
INSERT INTO Category VALUES (1, 'Electronics', 'Gadgets');
INSERT INTO Product VALUES (101, 'iPhone 15', 999.99, 50, 1);
INSERT INTO Customer VALUES (1, 'Ahmed Ali', 'ahmed@test.com', '010', 'Cairo');
INSERT INTO Cart_Items VALUES (1, 1, 999.99, 1, 101);
INSERT INTO OrderTable (OrderID, OrderDate, CustomerID) VALUES (5001, CURRENT_DATE, 1);
INSERT INTO Payment VALUES (700, 150.00, CURRENT_DATE, 'Credit Card', 5001);

-- 3. Complex Report Query (5 Joins)
SELECT 
    C.Name AS CustomerName,
    O.OrderID,
    Pay.Amount AS PaidAmount,
    Cat.Name AS CategoryName,
    P.Name AS ProductNameInCart
FROM 
    Payment Pay
JOIN 
    OrderTable O ON Pay.OrderID = O.OrderID            
JOIN 
    Customer C ON O.CustomerID = C.CustomerID          
JOIN 
    Cart_Items Cart ON C.CustomerID = Cart.CustomerID 
JOIN 
    Product P ON Cart.ProductID = P.ProductID          
JOIN 
    Category Cat ON P.CategoryID = Cat.CategoryID;