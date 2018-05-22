-- PROBLEM 1. FOOD
------- Step1. ------
--1.1 Create the tables identified below in the following order
-- Campus (CampusID, CampusName, Street, City, State, Zip, Phone, CampusDiscount)
DROP TABLE OrderLine CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE FoodItems CASCADE CONSTRAINTS;
DROP SEQUENCE Prices_FoodItemTypeID_SEQ;
DROP TABLE Prices CASCADE CONSTRAINTS;
DROP TABLE Members CASCADE CONSTRAINTS;
DROP TABLE Position CASCADE CONSTRAINTS;
DROP TABLE Campus CASCADE CONSTRAINTS;

CREATE TABLE Campus (
    CampusID          VARCHAR2(5) not null,
    CampusName        VARCHAR2(50),
    Street            VARCHAR2(50),
    City              VARCHAR2(20),
    State             VARCHAR2(20),
    Zip               NUMBER(10),
    Phone             VARCHAR2(20),
    CampusDiscount    DECIMAL(2,2),
    
    CONSTRAINT Campus_CampusID_PK PRIMARY KEY (CampusID)
);

-- Position (PositionID, Position, YearlyMembershipFee)
CREATE TABLE Position (
    PositionID        VARCHAR2(5) NOT NULL,
    Position          VARCHAR2(20),
    YearlyMembershipFee  DECIMAL (7,2),
    
    CONSTRAINT Position_PositionID_PK PRIMARY KEY(PositionId)
);


-- Members (MemberID, LastName, FirstName, CampusAddress, CampusPhone, CampusID, PositionID, ContractDuration)
--      FK   CampusID --> Campus(CampusID)
--           PositionID --> Position(PositionID)
CREATE TABLE Members (
    MemberID          VARCHAR2(5) NOT NULL,
    LastName          VARCHAR2(20),
    FirstName         VARCHAR2(20),
    CampusAddress     VARCHAR2(100),
    CampusPhone       VARCHAR2(20),
    CampusID          VARCHAR2(5),
    PositionID        VARCHAR2(5), 
    ContractDuration  NUMBER(3,0),
    
    CONSTRAINT Members_MemberID_PK PRIMARY KEY(MemberID),
    CONSTRAINT Campus_CampusID_FK FOREIGN KEY(CampusID) REFERENCES Campus(CampusID),
    CONSTRAINT Position_PositionID_FK FOREIGN KEY(PositionID) REFERENCES Position(PositionID)
);
                       
-- Sequence for Price table
CREATE SEQUENCE Prices_FoodItemID_Seq
    START WITH 1
        INCREMENT BY 1
        NOCACHE
        NOCYCLE;

-- Prices (FoodItemTypeID, MealType, MealPrice)
CREATE TABLE Prices (
    FoodItemTypeID        VARCHAR2(5) NOT NULL,
        MealType          VARCHAR2(20),
        MealPrice         DECIMAL(7,2),
        
        CONSTRAINT Prices_FoodItemTypeID_PK PRIMARY KEY(FoodItemTypeID)
);

-- FoodItems (FoodItemID, FoodItemName, FoodItemTypeID)
-- FK    FoodItemTypeID --> Prices(FoodItemTypeID)
CREATE TABLE FoodItems (
    FoodItemID      VARCHAR2(5) NOT NULL,
    FoodItemName    VARCHAR2(20),
    FoodItemTypeID  VARCHAR2(5),
    
    CONSTRAINT FoodItems_FoodItemID_PK PRIMARY KEY(FoodItemID),
    CONSTRAINT Prices_FoodItemTypeID_FK FOREIGN KEY(FoodItemTypeID) REFERENCES Prices(FoodItemTypeID)
);

-- Orders (OrderID, MemberID, OrderDate)
-- FK   MemberID --> Members(MemberID)
CREATE TABLE Orders (
    OrderID      VARCHAR2(5) NOT NULL,
    MemberID     VARCHAR2(5) NOT NULL,
    OrderDate    VARCHAR2(25),
    
    CONSTRAINT Orders_OrderID_PK PRIMARY KEY(OrderID),
    CONSTRAINT Members_MemberID_FK FOREIGN KEY(MemberID) REFERENCES Members(MemberID)
);


-- OrderLine (OrderID, FoodItemsID, Quantity)
-- FK   OrderID --> Orders(OrderID)
--      FoodItemsID --> FoodItems(FoodItemID)
CREATE TABLE OrderLine (
    OrderID      VARCHAR2(5) NOT NULL,
    FoodItemsID  VARCHAR2(5) NOT NULL,
    Quantity     NUMBER(3,0),
    
    CONSTRAINT OrderLine_OIFIID_PK PRIMARY KEY(OrderID,FoodItemsID),
    CONSTRAINT Orders_OrderID_FK FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FoodItems_FoodItemsID_FK FOREIGN KEY(FoodItemsID) REFERENCES FoodItems(FoodItemID)
);

----- Step 2. -----
-- 1.2.Use the Insert Into Command to add your data to each table
-- Campus
INSERT INTO Campus 
VALUES ('1', 'IUPUI', '425 University Blvd.','Indianapolis', 'IN', '46202', '317-274-4591',.08 );

INSERT INTO Campus 
VALUES ('2', 'Indiana University', '107 S. Indiana Ave.','Bloomington', 'IN', '47405', '812-855-4848',.07 );

INSERT INTO Campus
VALUES ('3', 'Purdue University', '475 Stadium Mall Drive','West Lafayette', 'IN', '47907', '765-494-1776',.06 );

-- Position
INSERT INTO Position
VALUES ('1', 'Lecturer', 1050.50);

INSERT INTO Position
VALUES ('2', 'Associate Professor', 900.50);

INSERT INTO Position
VALUES ('3', 'Assistant Professor', 875.50);

INSERT INTO Position
VALUES ('4', 'Professor', 700.75);

INSERT INTO Position
VALUES ('5', 'Full Professor', 500.50);

-- Members
INSERT INTO Members
VALUES ('1', 'Ellen', 'Monk', '009 Purnell', '812-123-1234', '2', '5', 12);

INSERT INTO Members
VALUES ('2', 'Joe', 'Brady', '008 Statford Hall', '765-234-2345', '3', '2', 10);

INSERT INTO Members
VALUES ('3', 'Dave', 'Davidson', '007 Purnell', '812-345-3456', '2', '3', 10);

INSERT INTO Members
VALUES ('4', 'Sebastian', 'Cole', '210 Rutherford Hall', '765-234-2345', '3', '5', 10);

INSERT INTO Members
VALUES ('5', 'Michael', 'Doo', '66C Peobody', '812-548-8956', '2', '1', 10);

INSERT INTO Members
VALUES ('6', 'Jerome', 'Clark', 'SL 220', '317-274-9766', '1', '1', 12);

INSERT INTO Members
VALUES ('7', 'Bob', 'House', 'ET 329', '317-278-9098', '1', '4', 10);

INSERT INTO Members
VALUES ('8', 'Bridget', 'Stanley', 'SI 234', '317-274-5678', '1', '1', 12);

INSERT INTO Members
VALUES ('9', 'Bradley', 'Wilson', '334 Statford Hall', '765-258-2567', '3', '2', 10);


-- Prices
INSERT INTO Prices
VALUES (Prices_FoodItemID_Seq.NEXTVAL, 'Beer/Wine', 5.50);

INSERT INTO Prices
VALUES (Prices_FoodItemID_Seq.NEXTVAL, 'Dessert', 2.75);

INSERT INTO Prices
VALUES (Prices_FoodItemID_Seq.NEXTVAL, 'Dinner', 15.50);

INSERT INTO Prices
VALUES (Prices_FoodItemID_Seq.NEXTVAL, 'Soft Drink', 2.50);

INSERT INTO Prices
VALUES (Prices_FoodItemID_Seq.NEXTVAL, 'Lunch', 7.25);


-- FoodItems
INSERT INTO FoodItems
VALUES ('10001', 'Lager', '1');

INSERT INTO FoodItems
VALUES ('10002', 'Red Wine', '1');

INSERT INTO FoodItems
VALUES ('10003', 'White Wine', '1');

INSERT INTO FoodItems
VALUES ('10004', 'Coke', '4');

INSERT INTO FoodItems
VALUES ('10005', 'Coffee', '4');

INSERT INTO FoodItems
VALUES ('10006', 'Chicken a la King', '3');

INSERT INTO FoodItems
VALUES ('10007', 'Rib Steak', '3');

INSERT INTO FoodItems
VALUES ('10008', 'Fish and Chips', '3');

INSERT INTO FoodItems
VALUES ('10009', 'Veggie Delight', '3');

INSERT INTO FoodItems
VALUES ('10010', 'Chocolate Mousse', '2');

INSERT INTO FoodItems
VALUES ('10011', 'Carrot Cake', '2');

INSERT INTO FoodItems
VALUES ('10012', 'Fruit Cup', '2');

INSERT INTO FoodItems
VALUES ('10013', 'Fish and Chips', '5');

INSERT INTO FoodItems
VALUES ('10014', 'Angus and Chips', '5');

INSERT INTO FoodItems
VALUES ('10015', 'Cobb Salad', '5');


-- Orders
INSERT INTO Orders
VALUES ( '1', '9', 'March 5, 2005' );

INSERT INTO Orders
VALUES ( '2', '8', 'March 5, 2005' );

INSERT INTO Orders
VALUES ( '3', '7', 'March 5, 2005' );

INSERT INTO Orders
VALUES ( '4', '6', 'March 7, 2005' );

INSERT INTO Orders
VALUES ( '5', '5', 'March 7, 2005' );

INSERT INTO Orders
VALUES ( '6', '4', 'March 10, 2005' );

INSERT INTO Orders
VALUES ( '7', '3', 'March 11, 2005' );

INSERT INTO Orders
VALUES ( '8', '2', 'March 12, 2005' );

INSERT INTO Orders
VALUES ( '9', '1', 'March 13, 2005' );

-- OrderLine
INSERT INTO OrderLine
VALUES ( '1', '10001', 1 );

INSERT INTO OrderLine
VALUES ( '1', '10006', 1 );

INSERT INTO OrderLine
VALUES ( '1', '10012', 1 );

INSERT INTO OrderLine
VALUES ( '2', '10004', 2 );

INSERT INTO OrderLine
VALUES ( '2', '10013', 1 );

INSERT INTO OrderLine
VALUES ( '2', '10014', 1 );

INSERT INTO OrderLine
VALUES ( '3', '10005', 1 );

INSERT INTO OrderLine
VALUES ( '3', '10011', 1 );

INSERT INTO OrderLine
VALUES ( '4', '10005', 2 );

INSERT INTO OrderLine
VALUES ( '4', '10004', 2 );

INSERT INTO OrderLine
VALUES ( '4', '10006', 1 );

INSERT INTO OrderLine
VALUES ( '4', '10007', 1 );

INSERT INTO OrderLine
VALUES ( '4', '10010', 2 );

INSERT INTO OrderLine
VALUES ( '5', '10003', 1 );

INSERT INTO OrderLine
VALUES ( '6', '10002', 2 );

INSERT INTO OrderLine
VALUES ( '7', '10005', 2 );

INSERT INTO OrderLine
VALUES ( '8', '10005', 1 );

INSERT INTO OrderLine
VALUES ( '8', '10011', 1 );

INSERT INTO OrderLine
VALUES ( '9', '10001', 1 );

----- Step 3. -----
-- 1.3.1. Select all records from each table 
SELECT *
FROM Campus;

SELECT *
FROM Position;

SELECT *
FROM Members;

SELECT * 
FROM Prices;

SELECT * 
FROM FoodItems;

SELECT * 
FROM Orders;

SELECT * 
FROM OrderLine;

-- 1.3.2. Create a listing of all Faculty Members
SELECT FirstName, LastName, Position, CampusName, (YearlyMembershipFee / 12 ) Monthly_Dues 
FROM Members, Position, Campus
WHERE Members.PositionID = Position.PositionID AND 
      Members.CampusID = Campus.CampusID
ORDER BY CampusName DESC, LastName ASC;

-- 1.3.3. Create a listing that shows the various food 
SELECT FoodItemName, MealType, MealPrice
FROM FoodItems, Prices
WHERE FoodItems.FoodItemTypeID = Prices.FoodItemTypeID AND
    MealType NOT LIKE '%Beer%' AND MealType NOT LIKE '%Wine%'
ORDER BY MealPrice ASC;

-- 1.3.4. Create a listing of order
SELECT Orders.OrderID, OrderDate, FirstName, LastName, CampusName, FoodItemName, 
    MealType, MealPrice, Quantity, (MealPrice * Quantity) Total
FROM  OrderLine, Orders, Members, FoodItems,Campus, Prices
WHERE FoodItems.FoodItemID = OrderLine.FoodItemsID AND
      OrderLine.OrderID = Orders.OrderID AND 
      Orders.MemberID = Members.MemberID AND
      Members.CampusID = Campus.CampusID AND 
      Prices.FoodItemTypeID = FoodItems.FoodItemTypeID
ORDER BY Orders.OrderID DESC;