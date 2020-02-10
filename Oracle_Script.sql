--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      TomorrowFinal.DM1
--
-- Date Created : Thursday, February 06, 2020 11:29:12
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: Calendar 
--

CREATE TABLE Calendar(
    DateID               NUMBER(38, 0)    NOT NULL,
    DayNumberofWeek      NUMBER(3, 0)     NOT NULL,
    DayNumberofMonth     NUMBER(3, 0)     NOT NULL,
    DayNumberofYear      SMALLINT         NOT NULL,
    WeekNumberoffYear    NUMBER(3, 0)     NOT NULL,
    MonthNumberofYear    NUMBER(3, 0)     NOT NULL,
    CalendarQuarter      NUMBER(3, 0)     NOT NULL,
    CalendarYear         SMALLINT         NOT NULL,
    CalendarSemester     NUMBER(3, 0)     NOT NULL,
    FiscalQuarter        NUMBER(3, 0)     NOT NULL,
    FiscalYear           SMALLINT         NOT NULL,
    FiscalSemester       NUMBER(3, 0)     NOT NULL,
    CONSTRAINT PK21 PRIMARY KEY (DateID)
)
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeKey                             NUMBER(38, 0)     NOT NULL,
    ActiveFlag                              BINARY_DOUBLE,
    SalesTerritory                          NUMBER(38, 0),
    EmployeeType                            CHAR(18)          NOT NULL,
    ParentEmployeeKey                       NUMBER(38, 0),
    --EmployeeNationalIDAlternateKey          NVARCHAR2(15),
    --ParentEmployeeNationalIDAlternateKey    NVARCHAR2(15),
    SalesTerritoryKey                       NUMBER(38, 0),
    FirstName                               NVARCHAR2(50)     NOT NULL,
    LastName                                NVARCHAR2(50)     NOT NULL,
    MiddleName                              NVARCHAR2(50),
    NameStyle                               NUMBER(1, 0)      NOT NULL,
    Title                                   NVARCHAR2(50),
    HireDate                                DATE,
    BirthDate                               DATE,
    LoginID                                 NVARCHAR2(256),
    EmailAddress                            NVARCHAR2(50),
    Phone                                   NVARCHAR2(25),
    MaritalStatus                           NCHAR(1),
    EmergencyContactName                    NVARCHAR2(50),
    EmergencyContactPhone                   NVARCHAR2(25),
    SalariedFlag                            NUMBER(1, 0),
    Gender                                  NCHAR(1),
    PayFrequency                            NUMBER(3, 0),
    BaseRate                                NUMBER(19, 2),
    VacationHours                           SMALLINT,
    SickLeaveHours                          SMALLINT,
    CurrentFlag                             NUMBER(1, 0),
    SalesPersonFlag                         NUMBER(1, 0),
    DepartmentName                          NVARCHAR2(50),
    StartDate                               DATE,
    EndDate                                 DATE,
    Status                                  NVARCHAR2(50),
    EmployeePhoto                           BLOB,
    GeographyID_SK                          NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK_Employee_EmployeeKey PRIMARY KEY (EmployeeKey)
)
;



-- 
-- TABLE: FactProductInventory 
--

CREATE TABLE FactProductInventory(
    Shelf           NVARCHAR2(10)    NOT NULL
                    CONSTRAINT CK_ProductInventory_Shelf CHECK (Shelf like '[A-Za-z]' OR Shelf ='N/A'),
    ModifiedDate    NUMBER(38, 0)    NOT NULL,
    CostRate        NUMBER(19, 4),
    Availability    NUMBER(8, 2),
    LocationName    NVARCHAR2(50),
    Bin             NUMBER(3, 0)     NOT NULL
                    CONSTRAINT CK_ProductInventory_Bin CHECK (Bin >= (0) AND Bin <=(100)),
    Quantity        SMALLINT         DEFAULT ((0)) NOT NULL
)
;



-- 
-- TABLE: FactPurchase 
--

CREATE TABLE FactPurchase(
    ProductID           NUMBER(38, 0)    NOT NULL,
    EmployeeKey         NUMBER(38, 0)    NOT NULL,
    BusinessEntityID    NUMBER(38, 0)    NOT NULL,
    SalesTerritory      NUMBER(38, 0),
    ShippingCompany     NVARCHAR2(50),
    ShipBase            NUMBER(19, 4),
    ShipRate            NUMBER(19, 4),
    OrderQty            SMALLINT,
    UnitPrice           NUMBER(19, 4),
    ReceivedQty         NUMBER(8, 2),
    RejectedQty         NUMBER(8, 2),
    StockedQty          NUMBER(9, 2),
    LineTotal           NUMBER(19, 4),
    DueDate             NUMBER(38, 0),
    RevisionNumber      NUMBER(3, 0)     DEFAULT (0) NOT NULL,
    Status              NUMBER(3, 0)     DEFAULT (1) NOT NULL
                        CONSTRAINT CK_Status CHECK (Status>=(1) AND Status<=(4)),
    EmployeeID          NUMBER(38, 0)    NOT NULL,
    VendorID            NUMBER(38, 0)    NOT NULL,
    OrderDate           NUMBER(38, 0),
    ShipDate            NUMBER(38, 0),
    SubTotal            NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_SubTotal CHECK (SubTotal>=(0.00)),
    TaxAmt              NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_TaxAmt CHECK (TaxAmt>=(0.00)),
    Freight             NUMBER(19, 4)    DEFAULT (0.00) NOT NULL
                        CONSTRAINT CK_Freight CHECK (Freight>=(0.00)),
    TotalDue            NUMBER(19, 4)    NOT NULL,
    ModifiedDate        NUMBER(38, 0),
    CONSTRAINT PK_PurchaseOrderID PRIMARY KEY (ProductID, EmployeeKey, BusinessEntityID)
)
;



-- 
-- TABLE: Geography 
--

CREATE TABLE Geography(
    GeographyID_SK    NUMBER(38, 0)    NOT NULL,
    Country           NVARCHAR2(40),
    State             NVARCHAR2(40),
    City              NVARCHAR2(40),
    PostalCode        NVARCHAR2(10),
    SalesTerritory    NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK20 PRIMARY KEY (GeographyID_SK)
)
;



-- 
-- TABLE: Product 
--

CREATE TABLE Product(
    ProductID                  NUMBER(38, 0)    NOT NULL,
    VendorPrice                NUMBER(19, 4),
    ProductModelName           CHAR(10),
    ModelCatalogDescription    CHAR(10),
    ModelInstructions          CHAR(10),
    ProductSubCategoryName     CHAR(10),
    ProductCategoryName        CHAR(10),
    ProductName                       CHAR(10)         NOT NULL,
    ProductNumber              NVARCHAR2(25)    NOT NULL,
    MakeFlag                   CHAR(10)         DEFAULT ((1)) NOT NULL,
    FinishedGoodsFlag          CHAR(10)         DEFAULT ((1)) NOT NULL,
    Color                      NVARCHAR2(15),
    SafetyStockLevel           SMALLINT         NOT NULL
                               CONSTRAINT CK_Product_SafetyStockLevel CHECK (SafetyStockLevel>(0)),
    ReorderPoint               SMALLINT         NOT NULL
                               CONSTRAINT CK_Product_ReorderPoint CHECK (ReorderPoint>(0)),
    StandardCost               NUMBER(19, 4)    NOT NULL
                               CONSTRAINT CK_Product_StandardCost CHECK (StandardCost>=(0.00)),
    ListPrice                  NUMBER(19, 4)    NOT NULL
                               CONSTRAINT CK_Product_ListPrice CHECK (ListPrice>=(0.00)),
    ProductSize                       NVARCHAR2(5),
    SizeUnitMeasureCode        NCHAR(3),
    WeightUnitMeasureCode      NCHAR(3),
    Weight                     NUMBER(8, 2)     
                               CONSTRAINT CK_Product_Weight CHECK (Weight>(0.00)),
    DaysToManufacture          NUMBER(38, 0)    NOT NULL
                               CONSTRAINT CK_Product_DaysToManufacture CHECK (DaysToManufacture>=(0)),
    ProductLine                NCHAR(2)         
                               CONSTRAINT CK_Product_ProductLine CHECK (upper(ProductLine)='R' OR upper(ProductLine)='M' OR upper(ProductLine)='T' OR upper(ProductLine)='S' OR ProductLine IS NULL),
    ProductClass                      NCHAR(2)         
                               CONSTRAINT CK_Product_Class CHECK (upper(ProductClass)='H' OR upper(ProductClass)='M' OR upper(ProductClass)='L' OR ProductClass IS NULL),
    ProductStyle                      NCHAR(2)         
                               CONSTRAINT CK_Product_Style CHECK (upper(ProductStyle)='U' OR upper(ProductStyle)='M' OR upper(ProductStyle)='W' OR ProductStyle IS NULL),
    SellStartDate              TIMESTAMP(6)     NOT NULL,
    SellEndDate                TIMESTAMP(6),
    DiscontinuedDate           TIMESTAMP(6),
    rowguid                    RAW(16)        NOT NULL,
    ModifiedDate               TIMESTAMP(6)      NOT NULL,
    BusinessEntityID           NUMBER(38, 0)    NOT NULL,
    DateID                     NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK_Product_ProductID PRIMARY KEY (ProductID)
)
;



-- 
-- TABLE: ProductCostHistory 
--

CREATE TABLE ProductCostHistory(
    ProductID       NUMBER(38, 0)    NOT NULL,
    StartDate       TIMESTAMP(6)     NOT NULL,
    ActiveFlag      RAW(10)          NOT NULL,
    EndDate         TIMESTAMP(6),
    StandardCost    NUMBER(19, 4)    NOT NULL
                    CONSTRAINT CK_StandardCost CHECK (StandardCost>=(0.00)),
    ModifiedDate    DATE   ,
    CONSTRAINT PK_ProductID_StartDate PRIMARY KEY (ProductID, StartDate)
)
;
 

-- 
-- TABLE: ProductListPriceHistory 
--

CREATE TABLE ProductListPriceHistory(
    ProductID       NUMBER(38, 0)    NOT NULL,
    StartDate       TIMESTAMP(6)     NOT NULL,
    ActiveFlag      RAW(10),
    EndDate         TIMESTAMP(6),
    ListPrice       NUMBER(19, 4)    NOT NULL
                    CONSTRAINT CK_ListPrice CHECK (ListPrice>(0.00)),
    ModifiedDate    TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK_ProductListPrice_StartDate PRIMARY KEY (ProductID, StartDate)
)
;



-- 
-- TABLE: SalesTerritory 
--

CREATE TABLE SalesTerritory(
    SalesTerritory           NUMBER(38, 0)    NOT NULL,
    SalesTerritoryRegion     VARCHAR2(50)     NOT NULL,
    SalesTerritoryGroup      NVARCHAR2(50),
    SalesTerritoryCountry    NVARCHAR2(50)    NOT NULL,
    CONSTRAINT PK18 PRIMARY KEY (SalesTerritory)
)
;



-- 
-- TABLE: Vendor 
--

CREATE TABLE Vendor(
    BusinessEntityID           NUMBER(38, 0)      NOT NULL,
    AccountNumber              CHAR(10)           NOT NULL,
    Name                       CHAR(10)           NOT NULL,
    CreditRating               NUMBER(3, 0)       NOT NULL
                               CONSTRAINT CK_Vendor_CreditRating CHECK (CreditRating>=(1) AND CreditRating<=(5)),
    PreferredVendorStatus      CHAR(10)           DEFAULT ((1)) NOT NULL,
    ActiveFlag                 CHAR(10)           DEFAULT ((1)) NOT NULL,
    PurchasingWebServiceURL    NVARCHAR2(1024),
    ModifiedDate               TIMESTAMP(6)      NOT NULL,
    GeographyID_SK             NUMBER(38, 0)      NOT NULL,
    CONSTRAINT PK_Vendor_BusinessEntityID PRIMARY KEY (BusinessEntityID)
)
;



-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefSalesTerritory20 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefGeography23 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES Geography(GeographyID_SK)
;


-- 
-- TABLE: FactProductInventory 
--

ALTER TABLE FactProductInventory ADD CONSTRAINT RefCalendar38 
    FOREIGN KEY (ModifiedDate)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: FactPurchase 
--

ALTER TABLE FactPurchase ADD CONSTRAINT RefProduct14 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefDimEmployee15 
    FOREIGN KEY (EmployeeKey)
    REFERENCES DimEmployee(EmployeeKey)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefVendor16 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Vendor(BusinessEntityID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefSalesTerritory22 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar31 
    FOREIGN KEY (DueDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar32 
    FOREIGN KEY (ModifiedDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar33 
    FOREIGN KEY (ShipDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar34 
    FOREIGN KEY (OrderDate)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: Geography 
--

ALTER TABLE Geography ADD CONSTRAINT RefSalesTerritory27 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;


-- 
-- TABLE: Product 
--

ALTER TABLE Product ADD CONSTRAINT RefVendor19 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Vendor(BusinessEntityID)
;

ALTER TABLE Product ADD CONSTRAINT RefCalendar30 
    FOREIGN KEY (DateID)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: ProductCostHistory 
--

ALTER TABLE ProductCostHistory ADD CONSTRAINT RefProduct11 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductListPriceHistory 
--

ALTER TABLE ProductListPriceHistory ADD CONSTRAINT RefProduct12 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: Vendor 
--

ALTER TABLE Vendor ADD CONSTRAINT RefGeography26 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES Geography(GeographyID_SK)
;


