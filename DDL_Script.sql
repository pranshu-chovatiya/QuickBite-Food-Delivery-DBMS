CREATE DATABASE IF NOT EXISTS QuickBite;
USE QuickBite;


-- ============================================================
--  TABLE: Address
--  (Created first — referenced by User, Restaurant, Orders)
-- ============================================================

CREATE TABLE Address (
    Add_ID     BIGINT       PRIMARY KEY,
    Add_line_1 VARCHAR(100),
    Add_line_2 VARCHAR(100),
    Area       VARCHAR(50),
    City       VARCHAR(50),
    Pincode    CHAR(6)                                 -- CHAR to preserve leading zeros
);


-- ============================================================
--  TABLE: User
-- ============================================================

CREATE TABLE User (
    UserID        BIGINT        PRIMARY KEY AUTO_INCREMENT,
    User_Name     VARCHAR(100)  NOT NULL,
    Email         VARCHAR(100)  NOT NULL UNIQUE,
    Phone_No      VARCHAR(15)   NOT NULL UNIQUE,
    Password_Hash VARCHAR(255)  NOT NULL,              -- hashed password for auth
    Profile_Pic   VARCHAR(300)  DEFAULT NULL,          -- URL to profile image
    Is_Active     BOOLEAN       DEFAULT TRUE,          -- account active/banned
    Created_At    DATETIME      DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
--  TABLE: User_Address  (Junction: User ↔ Address)
-- ============================================================

CREATE TABLE User_Address (
    UserID     BIGINT,
    Add_ID     BIGINT,
    Is_Default BOOLEAN     DEFAULT FALSE,              -- which address is default delivery
    Label      VARCHAR(20) DEFAULT 'Home',             -- Home / Work / Other
    PRIMARY KEY (UserID, Add_ID),
    FOREIGN KEY (UserID)  REFERENCES User(UserID),
    FOREIGN KEY (Add_ID)  REFERENCES Address(Add_ID)
);


-- ============================================================
--  TABLE: Restaurant
-- ============================================================

CREATE TABLE Restaurant (
    Restaurant_ID     BIGINT        PRIMARY KEY,
    Resto_Name        VARCHAR(50)   NOT NULL,
    Open_Time         TIME,
    Close_Time        TIME,
    Restaurant_Status BOOLEAN       DEFAULT TRUE,
    FSSAI_License_No  BIGINT        UNIQUE,
    Contact_No        VARCHAR(15),
    Add_ID            BIGINT,
    Rating            DECIMAL(3,1)  DEFAULT 0,
    Total_Reviews     INT           DEFAULT 0,
    Min_Order_Amount  INT           DEFAULT 0,         -- minimum order value to place order
    Avg_Delivery_Time INT           DEFAULT 30,        -- estimated delivery time in minutes
    FOREIGN KEY (Add_ID) REFERENCES Address(Add_ID)
);


-- ============================================================
--  TABLE: Cuisine  (Multi-valued attribute of Restaurant)
-- ============================================================

CREATE TABLE Cuisine (
    Cuisine       VARCHAR(30),
    Restaurant_ID BIGINT,
    PRIMARY KEY (Cuisine, Restaurant_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)
);


-- ============================================================
--  TABLE: Menu_Category
-- ============================================================

CREATE TABLE Menu_Category (
    Category_Name VARCHAR(30),
    Cat_Type      VARCHAR(10),
    Restaurant_ID BIGINT,
    PRIMARY KEY (Category_Name, Restaurant_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)
);


-- ============================================================
--  TABLE: Menu_Item
-- ============================================================

CREATE TABLE Menu_Item (
    Item_ID             BIGINT        PRIMARY KEY,
    Item_Name           VARCHAR(50)   NOT NULL,
    Description         VARCHAR(200),
    Price               INT           NOT NULL,
    Preparation_Time    INT,                           -- in minutes
    Is_Available        BOOLEAN       DEFAULT TRUE,
    Is_Veg              BOOLEAN,
    Weight              INT,                           -- in grams
    Total_Rating        INT           DEFAULT 0,       -- number of ratings received
    Rating              FLOAT         DEFAULT 0,       -- average rating score
    Calories            INT,
    Protein             FLOAT,
    Carbs               FLOAT,
    Fat                 FLOAT,
    Image_URL           VARCHAR(300)  DEFAULT NULL,    -- food item image URL
    Discount_Percentage INT           DEFAULT 0,       -- item-level discount %
    Category_Name       VARCHAR(30),
    Restaurant_ID       BIGINT,
    FOREIGN KEY (Category_Name, Restaurant_ID)
        REFERENCES Menu_Category(Category_Name, Restaurant_ID)
);


-- ============================================================
--  TABLE: Coupon
-- ============================================================

CREATE TABLE Coupon (
    Coupon_ID       BIGINT       PRIMARY KEY,
    Coupon_Code     VARCHAR(20)  NOT NULL UNIQUE,      -- e.g. SAVE20, FIRST50
    Description     VARCHAR(100),
    Discount_PR     INT          DEFAULT 0,            -- percentage off
    Discount_Amount INT          DEFAULT 0,            -- flat off in ₹
    Min_Order_Value INT          DEFAULT 0,            -- minimum cart value to apply
    Max_Uses        INT          DEFAULT 100,          -- total times coupon can be used
    Used_Count      INT          DEFAULT 0,            -- how many times used so far
    Valid_From      DATE,
    Valid_Till      DATE,
    Is_Active       BOOLEAN      DEFAULT TRUE
);


-- ============================================================
--  TABLE: Discount
-- ============================================================

CREATE TABLE Discount (
    Discount_ID     BIGINT PRIMARY KEY,
    Discount_PR     INT    DEFAULT 0,
    Discount_Amount INT    DEFAULT 0,
    Coupon_ID       BIGINT DEFAULT NULL,               -- which coupon triggered this discount
    FOREIGN KEY (Coupon_ID) REFERENCES Coupon(Coupon_ID)
);


-- ============================================================
--  TABLE: Cart
-- ============================================================

CREATE TABLE Cart (
    Cart_ID      BIGINT     PRIMARY KEY,
    Created_At   TIMESTAMP,
    Updated_At   TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Status       VARCHAR(20),                          -- Active / Ordered / Abandoned
    Total_Amount INT        DEFAULT 0,                 -- running cart total
    UserID       BIGINT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- ============================================================
--  TABLE: Cart_Item  (Junction: Cart ↔ Menu_Item)
-- ============================================================

CREATE TABLE Cart_Item (
    Cart_ID  BIGINT,
    Item_ID  BIGINT,
    Quantity INT,
    PRIMARY KEY (Cart_ID, Item_ID),
    FOREIGN KEY (Cart_ID) REFERENCES Cart(Cart_ID),
    FOREIGN KEY (Item_ID) REFERENCES Menu_Item(Item_ID)
);


-- ============================================================
--  TABLE: Orders
-- ============================================================

CREATE TABLE Orders (
    OrderID              BIGINT       PRIMARY KEY,
    Date_Time            TIMESTAMP,
    Order_Status         VARCHAR(20)  DEFAULT 'Placed', -- Placed/Preparing/OutForDelivery/Delivered/Cancelled
    Total_Amount         INT          DEFAULT 0,         -- final billed amount after discount
    Special_Instructions VARCHAR(200) DEFAULT NULL,      -- e.g. "no onion", "extra spicy"
    UserID               BIGINT,
    Add_ID               BIGINT,
    Discount_ID          BIGINT,
    FOREIGN KEY (UserID)      REFERENCES User(UserID),
    FOREIGN KEY (Add_ID)      REFERENCES Address(Add_ID),
    FOREIGN KEY (Discount_ID) REFERENCES Discount(Discount_ID)
);


-- ============================================================
--  TABLE: Order_Status_Log  (Audit trail for order lifecycle)
-- ============================================================

CREATE TABLE Order_Status_Log (
    Log_ID     BIGINT       PRIMARY KEY AUTO_INCREMENT,
    OrderID    BIGINT,
    Status     VARCHAR(20),
    Changed_At TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    Note       VARCHAR(100) DEFAULT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- ============================================================
--  TABLE: Order_Item  (Junction: Orders ↔ Menu_Item)
-- ============================================================

CREATE TABLE Order_Item (
    OrderID  BIGINT,
    Item_ID  BIGINT,
    Quantity INT,
    Price    INT,                                      -- price at time of order (snapshot)
    PRIMARY KEY (OrderID, Item_ID),
    FOREIGN KEY (OrderID)  REFERENCES Orders(OrderID),
    FOREIGN KEY (Item_ID)  REFERENCES Menu_Item(Item_ID)
);


-- ============================================================
--  TABLE: Delivery_Partner
-- ============================================================

CREATE TABLE Delivery_Partner (
    Partner_ID       BIGINT        PRIMARY KEY,
    Name             VARCHAR(50),
    Phone_No         VARCHAR(15),
    Vehicle_No       CHAR(12),
    Rating           DECIMAL(3,1)  DEFAULT 0,
    Is_Available     BOOLEAN       DEFAULT TRUE,       -- currently free or on delivery
    City             VARCHAR(50),                      -- city they operate in
    Total_Deliveries INT           DEFAULT 0,          -- lifetime delivery count
    Joining_Date     DATE
);


-- ============================================================
--  TABLE: Delivery
-- ============================================================

CREATE TABLE Delivery (
    Delivery_ID      BIGINT     PRIMARY KEY,
    Pickup_Time      TIMESTAMP,
    Delivery_Time    TIMESTAMP,
    Status           VARCHAR(15),                      -- Picked/InTransit/Delivered
    Delivery_Charges INT        DEFAULT 0,             -- delivery fee charged for this order
    OrderID          BIGINT,
    Partner_ID       BIGINT,
    FOREIGN KEY (OrderID)    REFERENCES Orders(OrderID),
    FOREIGN KEY (Partner_ID) REFERENCES Delivery_Partner(Partner_ID)
);


-- ============================================================
--  TABLE: Payment
-- ============================================================

CREATE TABLE Payment (
    Transaction_ID BIGINT     PRIMARY KEY,
    Mode           VARCHAR(15),                        -- UPI/Card/Cash/NetBanking/Wallet
    Amount         INT,
    Status         VARCHAR(10) DEFAULT 'Success',      -- Success/Failed/Pending
    Payment_Date   TIMESTAMP,                          -- when payment was made
    Order_ID       BIGINT,
    FOREIGN KEY (Order_ID) REFERENCES Orders(OrderID)
);


-- ============================================================
--  TABLE: Review
-- ============================================================

CREATE TABLE Review (
    Review_ID     BIGINT       PRIMARY KEY,
    Review        VARCHAR(300),
    Rating        DECIMAL(3,1),
    Review_Date   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    Restaurant_ID BIGINT,
    UserID        BIGINT,
    Partner_ID    BIGINT,
    CHECK (Restaurant_ID IS NOT NULL OR Partner_ID IS NOT NULL),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID),
    FOREIGN KEY (UserID)        REFERENCES User(UserID),
    FOREIGN KEY (Partner_ID)    REFERENCES Delivery_Partner(Partner_ID)
);


-- ============================================================
--  TABLE: Cancellation
-- ============================================================

CREATE TABLE Cancellation (
    Cancellation_ID BIGINT      PRIMARY KEY,
    Canceled_BY     BIGINT,                            -- UserID who cancelled
    Reason          VARCHAR(100),
    Cancel_At       TIMESTAMP,
    Refund_Eligible BOOLEAN,
    Penalty_Amount  INT         DEFAULT 0,
    Order_ID        BIGINT,
    FOREIGN KEY (Canceled_BY) REFERENCES User(UserID),
    FOREIGN KEY (Order_ID)    REFERENCES Orders(OrderID)
);


-- ============================================================
--  TABLE: Wallet
-- ============================================================

CREATE TABLE Wallet (
    Wallet_ID  BIGINT    PRIMARY KEY,
    Balance    INT       DEFAULT 0,
    Created_At TIMESTAMP,
    UserID     BIGINT    UNIQUE,                       -- one wallet per user
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- ============================================================
--  TABLE: Wallet_Transaction
-- ============================================================

CREATE TABLE Wallet_Transaction (
    Transaction_ID BIGINT     PRIMARY KEY,
    Wallet_ID      BIGINT,
    Type           VARCHAR(10),                        -- CREDIT / DEBIT
    Amount         INT,
    Balance_After  INT,                                -- wallet balance after this transaction
    Date_Time      TIMESTAMP,
    FOREIGN KEY (Wallet_ID) REFERENCES Wallet(Wallet_ID)
);


-- ============================================================
--  TABLE: Wallet_Topup
--  (Extends Wallet_Transaction for top-up specific details)
-- ============================================================

CREATE TABLE Wallet_Topup (
    Transaction_ID  BIGINT      PRIMARY KEY,
    Status          VARCHAR(10),
    Payment_Mode    VARCHAR(15),
    Transaction_Ref BIGINT,
    -- Date_Time removed: inherited from parent Wallet_Transaction
    FOREIGN KEY (Transaction_ID) REFERENCES Wallet_Transaction(Transaction_ID)
);


-- ============================================================
--  TABLE: Notification
-- ============================================================

CREATE TABLE Notification (
    Notification_ID BIGINT      PRIMARY KEY AUTO_INCREMENT,
    UserID          BIGINT,
    Title           VARCHAR(100),
    Message         VARCHAR(300),
    Type            VARCHAR(20),                       -- OrderUpdate/Promo/Refund/System
    Is_Read         BOOLEAN     DEFAULT FALSE,
    Created_At      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- ============================================================
--  TABLE: Complaint
-- ============================================================

CREATE TABLE Complaint (
    Complaint_ID BIGINT      PRIMARY KEY,
    OrderID      BIGINT,
    UserID       BIGINT,                               -- who raised the complaint
    Issue_Type   VARCHAR(30),
    Description  VARCHAR(200),
    Created_At   TIMESTAMP,
    Status       VARCHAR(10),                          -- Pending/Resolved/Rejected
    Resolved_At  TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (UserID)  REFERENCES User(UserID)
);


-- ============================================================
--  TABLE: Refund
-- ============================================================

CREATE TABLE Refund (
    Refund_ID     BIGINT     PRIMARY KEY,
    OrderID       BIGINT,
    Complaint_ID  BIGINT,
    Refund_Amount INT,
    Refund_Status VARCHAR(10),                         -- Pending/Completed/Rejected
    Initiated_At  TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
    Completed_At  TIMESTAMP,
    Wallet_ID     BIGINT,
    FOREIGN KEY (OrderID)      REFERENCES Orders(OrderID),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID),
    FOREIGN KEY (Wallet_ID)    REFERENCES Wallet(Wallet_ID)
);


-- ============================================================
--  INDEXES  (for query performance on high-traffic columns)
-- ============================================================

CREATE INDEX idx_orders_userid     ON Orders(UserID);
CREATE INDEX idx_orders_status     ON Orders(Order_Status);
CREATE INDEX idx_order_item_order  ON Order_Item(OrderID);
CREATE INDEX idx_delivery_order    ON Delivery(OrderID);
CREATE INDEX idx_review_restaurant ON Review(Restaurant_ID);
CREATE INDEX idx_notification_user ON Notification(UserID);
CREATE INDEX idx_complaint_order   ON Complaint(OrderID);
CREATE INDEX idx_menu_item_restoid ON Menu_Item(Restaurant_ID);
