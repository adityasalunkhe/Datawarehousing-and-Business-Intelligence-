--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      TomorrowFinal.DM1
--
-- Date Created : Thursday, February 06, 2020 13:47:38
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Calendar 
--

CREATE TABLE Calendar(
    DateID               INT         NOT NULL,
    DayNumberofWeek      TINYINT     NOT NULL,
    DayNumberofMonth     TINYINT     NOT NULL,
    DayNumberofYear      SMALLINT    NOT NULL,
    WeekNumberoffYear    TINYINT     NOT NULL,
    MonthNumberofYear    TINYINT     NOT NULL,
    CalendarQuarter      TINYINT     NOT NULL,
    CalendarYear         SMALLINT    NOT NULL,
    CalendarSemester     TINYINT     NOT NULL,
    FiscalQuarter        TINYINT     NOT NULL,
    FiscalYear           SMALLINT    NOT NULL,
    FiscalSemester       TINYINT     NOT NULL,
    PRIMARY KEY (DateID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeKey                             INT                      AUTO_INCREMENT,
    ActiveFlag                              BINARY(10),
    SalesTerritory                          INT,
    EmployeeType                            BINARY(10)               NOT NULL,
    ParentEmployeeKey                       INT,
    EmployeeNationalIDAlternateKey          NATIONAL VARCHAR(15),
    ParentEmployeeNationalIDAlternateKey    NATIONAL VARCHAR(15),
    SalesTerritoryKey                       INT,
    FirstName                               NATIONAL VARCHAR(50)     NOT NULL,
    LastName                                NATIONAL VARCHAR(50)     NOT NULL,
    MiddleName                              NATIONAL VARCHAR(50),
    NameStyle                               BIT(1)                   NOT NULL,
    Title                                   NATIONAL VARCHAR(50),
    HireDate                                DATE,
    BirthDate                               DATE,
    LoginID                                 NATIONAL VARCHAR(256),
    EmailAddress                            NATIONAL VARCHAR(50),
    Phone                                   NATIONAL VARCHAR(25),
    MaritalStatus                           NATIONAL CHAR(1),
    EmergencyContactName                    NATIONAL VARCHAR(50),
    EmergencyContactPhone                   NATIONAL VARCHAR(25),
    SalariedFlag                            BIT(1),
    Gender                                  NATIONAL CHAR(1),
    PayFrequency                            TINYINT,
    BaseRate                                DECIMAL(19, 2),
    VacationHours                           SMALLINT,
    SickLeaveHours                          SMALLINT,
    CurrentFlag                             BIT(1),
    SalesPersonFlag                         BIT(1),
    DepartmentName                          NATIONAL VARCHAR(50),
    StartDate                               DATE,
    EndDate                                 DATE,
    Status                                  NATIONAL VARCHAR(50),
    EmployeePhoto                           VARBINARY(4000),
    GeographyID_SK                          INT                      NOT NULL,
    PRIMARY KEY (EmployeeKey)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactProductInventory 
--

CREATE TABLE FactProductInventory(
    Shelf           NATIONAL VARCHAR(10)    NOT NULL,
    ModifiedDate    INT                     NOT NULL,
    CostRate        DECIMAL(19, 4),
    Availability    DECIMAL(8, 2),
    LocationName    NATIONAL VARCHAR(50),
    Bin             TINYINT                 NOT NULL,
    Quantity        SMALLINT                DEFAULT (0) NOT NULL
)ENGINE=MYISAM
;



-- 
-- TABLE: FactPurchase 
--

CREATE TABLE FactPurchase(
    ProductID           INT                     NOT NULL,
    EmployeeKey         INT                     NOT NULL,
    BusinessEntityID    INT                     NOT NULL,
    SalesTerritory      INT,
    ShippingCompany     NATIONAL VARCHAR(50),
    ShipBase            DECIMAL(19, 4),
    ShipRate            DECIMAL(19, 4),
    OrderQty            SMALLINT,
    UnitPrice           DECIMAL(19, 4),
    ReceivedQty         DECIMAL(8, 2),
    RejectedQty         DECIMAL(8, 2),
    StockedQty          DECIMAL(9, 2),
    LineTotal           DECIMAL(19, 4),
    DueDate             INT,
    RevisionNumber      TINYINT                 DEFAULT (0) NOT NULL,
    Status              TINYINT                 DEFAULT (1) NOT NULL,
    EmployeeID          INT                     NOT NULL,
    VendorID            INT                     NOT NULL,
    OrderDate           INT,
    ShipDate            INT,
    SubTotal            DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL,
    TaxAmt              DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL,
    Freight             DECIMAL(19, 4)          DEFAULT (0.00) NOT NULL,
    TotalDue            DECIMAL(19, 4)          NOT NULL,
    ModifiedDate        INT,
    PRIMARY KEY (ProductID, EmployeeKey, BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: Geography 
--

CREATE TABLE Geography(
    GeographyID_SK    INT                     NOT NULL,
    Country           NATIONAL VARCHAR(40),
    State             NATIONAL VARCHAR(40),
    City              NATIONAL VARCHAR(40),
    PostalCode        NATIONAL VARCHAR(10),
    SalesTerritory    INT                     NOT NULL,
    PRIMARY KEY (GeographyID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Product 
--

CREATE TABLE Product(
    ProductID                  INT                     AUTO_INCREMENT,
    VendorPrice                DECIMAL(19, 4),
    ProductModelName           CHAR(10),
    ModelCatalogDescription    CHAR(10),
    ModelInstructions          CHAR(10),
    ProductSubCategoryName     CHAR(10),
    ProductCategoryName        CHAR(10),
    Name                       CHAR(10)                NOT NULL,
    ProductNumber              NATIONAL VARCHAR(25)    NOT NULL,
    MakeFlag                   CHAR(10)                DEFAULT ((1)) NOT NULL,
    FinishedGoodsFlag          CHAR(10)                DEFAULT ((1)) NOT NULL,
    Color                      NATIONAL VARCHAR(15),
    SafetyStockLevel           SMALLINT                NOT NULL,
    ReorderPoint               SMALLINT                NOT NULL,
    StandardCost               DECIMAL(19, 4)          NOT NULL,
    ListPrice                  DECIMAL(19, 4)          NOT NULL,
    Size                       NATIONAL VARCHAR(5),
    SizeUnitMeasureCode        NATIONAL CHAR(3),
    WeightUnitMeasureCode      NATIONAL CHAR(3),
    Weight                     DECIMAL(8, 2),
    DaysToManufacture          INT                     NOT NULL,
    ProductLine                NATIONAL CHAR(2),
    Class                      NATIONAL CHAR(2),
    Style                      NATIONAL CHAR(2),
    SellStartDate              DATETIME                NOT NULL,
    SellEndDate                DATETIME,
    DiscontinuedDate           DATETIME,
    rowguid                    BINARY(16)              NOT NULL,
    ModifiedDate               DATETIME                NOT NULL,
    BusinessEntityID           INT                     NOT NULL,
    DateID                     INT                     NOT NULL,
    PRIMARY KEY (ProductID)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductCostHistory 
--

CREATE TABLE ProductCostHistory(
    ProductID       INT               NOT NULL,
    StartDate       DATETIME          NOT NULL,
    ActiveFlag      BINARY(10)        NOT NULL,
    EndDate         DATETIME,
    StandardCost    DECIMAL(19, 4)    NOT NULL,
    ModifiedDate    DATETIME          NOT NULL,
    PRIMARY KEY (ProductID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: ProductListPriceHistory 
--

CREATE TABLE ProductListPriceHistory(
    ProductID       INT               NOT NULL,
    StartDate       DATETIME          NOT NULL,
    ActiveFlag      BINARY(10),
    EndDate         DATETIME,
    ListPrice       DECIMAL(19, 4)    NOT NULL,
    ModifiedDate    DATETIME          NOT NULL,
    PRIMARY KEY (ProductID, StartDate)
)ENGINE=MYISAM
;



-- 
-- TABLE: SalesTerritory 
--

CREATE TABLE SalesTerritory(
    SalesTerritory           INT                     NOT NULL,
    SalesTerritoryRegion     VARCHAR(50)             NOT NULL,
    SalesTerritoryGroup      NATIONAL VARCHAR(50),
    SalesTerritoryCountry    NATIONAL VARCHAR(50)    NOT NULL,
    PRIMARY KEY (SalesTerritory)
)ENGINE=MYISAM
;



-- 
-- TABLE: Vendor 
--

CREATE TABLE Vendor(
    BusinessEntityID           INT                       NOT NULL,
    AccountNumber              CHAR(10)                  NOT NULL,
    Name                       CHAR(10)                  NOT NULL,
    CreditRating               TINYINT                   NOT NULL,
    PreferredVendorStatus      CHAR(10)                  DEFAULT ((1)) NOT NULL,
    ActiveFlag                 CHAR(10)                  DEFAULT ((1)) NOT NULL,
    PurchasingWebServiceURL    NATIONAL VARCHAR(1024),
    ModifiedDate               DATETIME                  NOT NULL,
    GeographyID_SK             INT                       NOT NULL,
    PRIMARY KEY (BusinessEntityID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefSalesTerritory201 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefGeography231 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES Geography(GeographyID_SK)
;


-- 
-- TABLE: FactProductInventory 
--

ALTER TABLE FactProductInventory ADD CONSTRAINT RefCalendar381 
    FOREIGN KEY (ModifiedDate)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: FactPurchase 
--

ALTER TABLE FactPurchase ADD CONSTRAINT RefProduct141 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefDimEmployee151 
    FOREIGN KEY (EmployeeKey)
    REFERENCES DimEmployee(EmployeeKey)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefVendor161 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Vendor(BusinessEntityID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefSalesTerritory221 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar311 
    FOREIGN KEY (DueDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar321 
    FOREIGN KEY (ModifiedDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar331 
    FOREIGN KEY (ShipDate)
    REFERENCES Calendar(DateID)
;

ALTER TABLE FactPurchase ADD CONSTRAINT RefCalendar341 
    FOREIGN KEY (OrderDate)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: Geography 
--

ALTER TABLE Geography ADD CONSTRAINT RefSalesTerritory271 
    FOREIGN KEY (SalesTerritory)
    REFERENCES SalesTerritory(SalesTerritory)
;


-- 
-- TABLE: Product 
--

ALTER TABLE Product ADD CONSTRAINT RefVendor191 
    FOREIGN KEY (BusinessEntityID)
    REFERENCES Vendor(BusinessEntityID)
;

ALTER TABLE Product ADD CONSTRAINT RefCalendar301 
    FOREIGN KEY (DateID)
    REFERENCES Calendar(DateID)
;


-- 
-- TABLE: ProductCostHistory 
--

ALTER TABLE ProductCostHistory ADD CONSTRAINT RefProduct111 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: ProductListPriceHistory 
--

ALTER TABLE ProductListPriceHistory ADD CONSTRAINT RefProduct121 
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
;


-- 
-- TABLE: Vendor 
--

ALTER TABLE Vendor ADD CONSTRAINT RefGeography261 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES Geography(GeographyID_SK)
;


