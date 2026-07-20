USE QuickBite;

INSERT INTO Address (Add_ID, Add_line_1, Add_line_2, Area, City, Pincode) VALUES
(101, 'Street 1',  'Near Park',       'Sector 21',     'Gandhinagar', 382021),
(102, 'Street 2',  'Opp Mall',        'Sector 22',     'Ahmedabad',   380015),
(103, 'Street 3',  'Near Lake',       'Adajan',        'Surat',       395009),
(104, 'Street 4',  'Market Area',     'Alkapuri',      'Vadodara',    390007),
(105, 'Street 5',  'Near Temple',     'Raiya Road',    'Rajkot',      360005),
(106, 'Street 6',  'Bus Stand',       'Kalanala',      'Bhavnagar',   364001),
(107, 'Street 7',  'Railway Station', 'Digvijay Plot', 'Jamnagar',    361005),
(108, 'Street 8',  'Near College',    'Vidhyanagar',   'Anand',       388120),
(109, 'Street 9',  'Hospital Road',   'Modhera Road',  'Mehsana',     384002),
(110, 'Street 10', 'Garden Area',     'Mahendranagar', 'Morbi',       363642);

INSERT INTO User (UserID, User_Name, Email, Phone_No, Password_Hash, Is_Active, Created_At) VALUES
(1,  'Vivek', 'vivek@gmail.com', '9876543210', 'hashed_pw_1',  TRUE, '2025-10-20 10:00:00'),
(2,  'Rahul', 'rahul@gmail.com', '9123456780', 'hashed_pw_2',  TRUE, '2025-10-25 12:30:00'),
(3,  'Amit',  'amit@gmail.com',  '9000000001', 'hashed_pw_3',  TRUE, '2025-11-01 09:15:00'),
(4,  'Neha',  'neha@gmail.com',  '9000000002', 'hashed_pw_4',  TRUE, '2025-09-15 14:00:00'),
(5,  'Priya', 'priya@gmail.com', '9000000003', 'hashed_pw_5',  TRUE, '2025-10-26 16:45:00'),
(6,  'Karan', 'karan@gmail.com', '9000000004', 'hashed_pw_6',  TRUE, '2025-08-10 11:20:00'),
(7,  'Riya',  'riya@gmail.com',  '9000000005', 'hashed_pw_7',  TRUE, '2025-10-27 18:10:00'),
(8,  'Ankit', 'ankit@gmail.com', '9000000006', 'hashed_pw_8',  TRUE, '2025-07-05 08:00:00'),
(9,  'Sneha', 'sneha@gmail.com', '9000000007', 'hashed_pw_9',  TRUE, '2025-10-28 20:30:00'),
(10, 'Yash',  'yash@gmail.com',  '9000000008', 'hashed_pw_10', TRUE, '2025-10-29 09:45:00');

INSERT INTO User_Address (UserID, Add_ID, Is_Default, Label) VALUES
(1,101,TRUE,'Home'),(2,102,TRUE,'Home'),(3,103,TRUE,'Home'),
(4,104,TRUE,'Home'),(5,105,TRUE,'Home'),(6,106,TRUE,'Work'),
(7,107,TRUE,'Home'),(8,108,TRUE,'Home'),(9,109,TRUE,'Home'),
(10,110,TRUE,'Home');

INSERT INTO Restaurant
(Restaurant_ID, Resto_Name, Open_Time, Close_Time, Restaurant_Status, FSSAI_License_No, Contact_No, Add_ID, Rating, Total_Reviews, Min_Order_Amount, Avg_Delivery_Time)
VALUES
(201, 'FoodHub',      '10:00:00', '23:00:00', TRUE, 111001, '900001', 101, 4.5, 120, 100, 30),
(202, 'SpiceVilla',   '09:00:00', '22:00:00', TRUE, 111002, '900002', 102, 4.2,  98, 150, 35),
(203, 'TastyTown',    '11:00:00', '23:30:00', TRUE, 111003, '900003', 103, 4.0,  75, 120, 40),
(204, 'UrbanBite',    '08:00:00', '21:00:00', TRUE, 111004, '900004', 104, 4.8, 150,  80, 25),
(205, 'Cafe99',       '09:30:00', '22:30:00', TRUE, 111005, '900005', 105, 3.9,  60,  50, 20),
(206, 'FoodZone',     '10:00:00', '23:00:00', TRUE, 111006, '900006', 106, 4.1,  80, 100, 30),
(207, 'RoyalEat',     '11:00:00', '23:00:00', TRUE, 111007, '900007', 107, 4.6, 140, 200, 45),
(208, 'MealBox',      '08:30:00', '21:30:00', TRUE, 111008, '900008', 108, 4.3, 110, 150, 35),
(209, 'BiryaniHouse', '10:30:00', '23:30:00', TRUE, 111009, '900009', 109, 4.7, 160, 120, 30),
(210, 'PizzaWorld',   '09:00:00', '22:00:00', TRUE, 111010, '900010', 110, 4.4, 130, 100, 25);

INSERT INTO Cuisine VALUES
('Indian',   201),('Chinese',  201),('Italian',  202),
('Mexican',  203),('Indian',   204),('Cafe',     205),
('FastFood', 206),('Royal',    207),('Gujarati', 208),
('Biryani',  209);

INSERT INTO Menu_Category VALUES
('Veg',      'Food',  201),('NonVeg',   'Food',  201),
('Dessert',  'Food',  202),('Beverage', 'Drink', 202),
('Veg',      'Food',  203),('Snacks',   'Food',  204),
('Dessert',  'Food',  205),('Beverage', 'Drink', 206),
('FastFood', 'Food',  207),('Combo',    'Food',  208);

INSERT INTO Menu_Item
(Item_ID, Item_Name, Description, Price, Preparation_Time,
 Is_Available, Is_Veg, Weight, Total_Rating, Rating,
 Calories, Protein, Carbs, Fat, Discount_Percentage, Category_Name, Restaurant_ID)
VALUES
(1001,'Paneer Butter Masala','Rich creamy gravy',       220,15,TRUE,TRUE, 300,120,4.5,450,18,20,30, 0,'Veg',      201),
(1002,'Chicken Curry',       'Spicy and flavorful',     260,20,TRUE,FALSE,350,150,4.6,500,25,10,35, 5,'NonVeg',   201),
(1003,'Ice Cream',           'Vanilla sweet dessert',   100, 5,TRUE,TRUE, 150, 80,4.2,200, 4,25,10, 0,'Dessert',  202),
(1004,'Cold Drink',          'Chilled soft drink',       50, 2,TRUE,TRUE, 300, 60,4.0,150, 0,35, 0, 0,'Beverage', 202),
(1005,'Veg Thali',           'Complete meal platter',   180,20,TRUE,TRUE, 500, 90,4.3,600,20,60,25,10,'Veg',      203),
(1006,'Grilled Sandwich',    'Toasted snack',            90,10,TRUE,TRUE, 200, 70,4.1,300,10,30,15, 0,'Snacks',   204),
(1007,'Chocolate Cake',      'Soft sweet cake',         150,12,TRUE,TRUE, 250,110,4.7,400, 6,50,20, 0,'Dessert',  205),
(1008,'Fresh Juice',         'Natural fruit juice',      80, 5,TRUE,TRUE, 250, 65,4.2,120, 2,28, 1, 0,'Beverage', 206),
(1009,'Burger',              'Cheese loaded burger',    130,10,TRUE,FALSE,220,140,4.6,550,20,40,25,15,'FastFood',  207),
(1010,'Combo Meal',          'Burger + drink combo',    300,25,TRUE,FALSE,600,100,4.4,700,22,70,30, 5,'Combo',    208);

INSERT INTO Coupon (Coupon_ID, Coupon_Code, Description, Discount_PR, Discount_Amount, Min_Order_Value, Max_Uses, Used_Count, Valid_From, Valid_Till) VALUES
(1, 'FIRST50',  'First order flat ₹50 off',    0,  50, 100, 500, 120, '2025-10-01', '2025-12-31'),
(2, 'SAVE20',   '20% off on orders above ₹200',20,   0, 200, 300,  80, '2025-10-01', '2025-11-30'),
(3, 'WEEKEND15','15% off every weekend',       15,   0, 150, 200,  45, '2025-10-01', '2025-12-31'),
(4, 'FLAT100',  'Flat ₹100 off above ₹500',    0, 100, 500, 150,  30, '2025-11-01', '2025-12-31'),
(5, 'QUACK10',  'QuackBit loyalty 10% off',    10,   0,   0, 999,  60, '2025-09-01', '2025-12-31');

INSERT INTO Discount (Discount_ID, Discount_PR, Discount_Amount, Coupon_ID) VALUES
(1,  10,   0, NULL),
(2,  20,   0, 2),
(3,   0,  50, 1),
(4,   0, 100, 4),
(5,  15, 100, NULL),
(6,  25,   0, NULL),
(7,   0,  75, NULL),
(8,   5,   0, 5),
(9,  30,   0, NULL),
(10,  0, 150, NULL);

INSERT INTO Cart (Cart_ID, Created_At, Status, Total_Amount, UserID) VALUES
(1, '2025-10-20 10:00:00','Active',  440, 1),
(2, '2025-10-21 11:00:00','Active',  410, 2),
(3, '2025-10-22 12:00:00','Ordered', 450, 3),
(4, '2025-10-23 13:00:00','Active',  310, 4),
(5, '2025-10-24 14:00:00','Ordered', 560, 5),
(6, '2025-10-25 15:00:00','Active',  400, 6),
(7, '2025-10-26 16:00:00','Active',  330, 7),
(8, '2025-10-27 17:00:00','Ordered', 460, 8),
(9, '2025-10-28 18:00:00','Active',  620, 9),
(10,'2025-10-29 19:00:00','Active',  750,10);

INSERT INTO Cart_Item (Cart_ID, Item_ID, Quantity) VALUES
(1,1001,2),(1,1003,1),(2,1002,1),(2,1004,3),
(3,1005,2),(3,1006,1),(4,1007,1),(4,1008,2),
(5,1009,2),(5,1010,1),(6,1001,1),(6,1006,2),
(7,1003,2),(7,1009,1),(8,1004,1),(8,1005,2),
(9,1002,2),(9,1008,1),(10,1007,1),(10,1010,2);

INSERT INTO Orders (OrderID, Date_Time, Order_Status, Total_Amount, UserID, Add_ID, Discount_ID) VALUES
(1, '2025-10-20 10:30:00','Delivered', 594, 1,  101, 1),
(2, '2025-10-21 11:15:00','Delivered', 208, 2,  102, 2),
(3, '2025-10-22 12:45:00','Delivered', 450, 3,  103, 1),
(4, '2025-10-23 13:20:00','Cancelled', 150, 4,  104, 4),
(5, '2025-10-24 14:10:00','Delivered', 476, 5,  105, 1),
(6, '2025-10-25 15:05:00','Delivered', 202, 6,  106, 6),
(7, '2025-10-26 16:40:00','Delivered', 200, 7,  107, 1),
(8, '2025-10-27 17:25:00','Cancelled', 437, 8,  108, 8),
(9, '2025-10-28 18:55:00','Delivered', 460, 9,  109, 4),
(10,'2025-10-29 19:35:00','Delivered', 712, 10, 110, 5);

INSERT INTO Order_Status_Log (Log_ID, OrderID, Status, Changed_At) VALUES
(1,  1, 'Placed',          '2025-10-20 10:30:00'),
(2,  1, 'Preparing',       '2025-10-20 10:35:00'),
(3,  1, 'OutForDelivery',  '2025-10-20 10:45:00'),
(4,  1, 'Delivered',       '2025-10-20 11:15:00'),
(5,  2, 'Placed',          '2025-10-21 11:15:00'),
(6,  2, 'Preparing',       '2025-10-21 11:20:00'),
(7,  2, 'OutForDelivery',  '2025-10-21 11:30:00'),
(8,  2, 'Delivered',       '2025-10-21 12:00:00'),
(9,  4, 'Placed',          '2025-10-23 13:20:00'),
(10, 4, 'Cancelled',       '2025-10-23 14:00:00'),
(11, 8, 'Placed',          '2025-10-27 17:25:00'),
(12, 8, 'Preparing',       '2025-10-27 17:30:00'),
(13, 8, 'Cancelled',       '2025-10-27 18:00:00'),
(14, 9, 'Placed',          '2025-10-28 18:55:00'),
(15, 9, 'Preparing',       '2025-10-28 19:00:00'),
(16, 9, 'OutForDelivery',  '2025-10-28 19:10:00'),
(17, 9, 'Delivered',       '2025-10-28 19:50:00');

INSERT INTO Order_Item (OrderID, Item_ID, Quantity, Price) VALUES
(1,1001,2,220),(1,1003,1,100),(2,1002,1,260),(2,1004,2, 50),
(3,1005,2,180),(3,1006,1, 90),(4,1007,1,150),(4,1008,2, 80),
(5,1009,2,130),(5,1010,1,300),(6,1001,1,220),(6,1006,2, 90),
(7,1003,2,100),(7,1009,1,130),(8,1004,1, 50),(8,1005,2,180),
(9,1002,2,260),(9,1008,1, 80),(10,1007,1,150),(10,1010,2,300);

INSERT INTO Delivery_Partner (Partner_ID, Name, Phone_No, Vehicle_No, Rating, Is_Available, City, Total_Deliveries, Joining_Date) VALUES
(1,  'Amit',    '9000000001', 'GJ01AA1111', 4.5, TRUE,  'Gandhinagar', 245, '2024-01-15'),
(2,  'Rahul',   '9000000002', 'GJ01AA2222', 4.2, TRUE,  'Ahmedabad',   198, '2024-02-10'),
(3,  'Karan',   '9000000003', 'GJ01AA3333', 4.0, TRUE,  'Surat',       176, '2024-03-05'),
(4,  'Rohit',   '9000000004', 'GJ01AA4444', 4.8, TRUE,  'Vadodara',    312, '2023-12-20'),
(5,  'Vikas',   '9000000005', 'GJ01AA5555', 3.9, FALSE, 'Rajkot',      134, '2024-04-01'),
(6,  'Suresh',  '9000000006', 'GJ01AA6666', 4.1, TRUE,  'Bhavnagar',   167, '2024-01-30'),
(7,  'Mahesh',  '9000000007', 'GJ01AA7777', 4.6, TRUE,  'Jamnagar',    289, '2023-11-10'),
(8,  'Naresh',  '9000000008', 'GJ01AA8888', 4.3, FALSE, 'Anand',       210, '2024-02-25'),
(9,  'Jignesh', '9000000009', 'GJ01AA9999', 4.7, TRUE,  'Mehsana',     276, '2023-10-05'),
(10, 'Ramesh',  '9000000010', 'GJ01AA0000', 4.4, TRUE,  'Morbi',       223, '2024-03-18');

INSERT INTO Delivery (Delivery_ID, Pickup_Time, Delivery_Time, Status, Delivery_Charges, OrderID, Partner_ID) VALUES
(1,  '2025-10-20 10:45:00', '2025-10-20 11:15:00', 'Delivered', 30, 1,  1),
(2,  '2025-10-21 11:30:00', '2025-10-21 12:00:00', 'Delivered', 25, 2,  2),
(3,  '2025-10-22 13:00:00', '2025-10-22 13:40:00', 'Delivered', 30, 3,  3),
(4,  '2025-10-23 13:30:00', '2025-10-23 14:10:00', 'Delivered', 20, 4,  4),
(5,  '2025-10-24 14:30:00', '2025-10-24 15:10:00', 'Delivered', 30, 5,  5),
(6,  '2025-10-25 15:20:00', '2025-10-25 16:00:00', 'Delivered', 25, 6,  6),
(7,  '2025-10-26 17:00:00', '2025-10-26 17:50:00', 'Delivered', 35, 7,  7),
(8,  '2025-10-27 17:40:00', NULL,                  'InTransit', 30, 8,  8),
(9,  '2025-10-28 19:00:00', '2025-10-28 19:50:00', 'Delivered', 20, 9,  9),
(10, '2025-10-29 20:00:00', NULL,                  'Picked',    25, 10, 10);

INSERT INTO Payment (Transaction_ID, Mode, Amount, Status, Payment_Date, Order_ID) VALUES
(1,  'UPI',        594, 'Success', '2025-10-20 10:31:00', 1),
(2,  'Card',       208, 'Success', '2025-10-21 11:16:00', 2),
(3,  'Cash',       450, 'Success', '2025-10-22 13:40:00', 3),
(4,  'UPI',        150, 'Success', '2025-10-23 13:21:00', 4),
(5,  'Card',       476, 'Success', '2025-10-24 14:11:00', 5),
(6,  'Cash',       202, 'Success', '2025-10-25 16:00:00', 6),
(7,  'Wallet',     200, 'Success', '2025-10-26 16:41:00', 7),
(8,  'Card',       437, 'Success', '2025-10-27 17:26:00', 8),
(9,  'NetBanking', 460, 'Success', '2025-10-28 18:56:00', 9),
(10, 'UPI',        712, 'Success', '2025-10-29 19:36:00', 10);

INSERT INTO Review (Review_ID, Review, Rating, Review_Date, Restaurant_ID, UserID, Partner_ID) VALUES
(1,  'Food was amazing and fresh',        4.5, '2025-10-20 12:00:00', 201, 1,  NULL),
(2,  'Nice taste but slightly expensive', 4.0, '2025-10-21 13:00:00', 202, 2,  NULL),
(3,  'Average food quality',              3.5, '2025-10-22 14:00:00', 203, 3,  NULL),
(4,  'Excellent, highly recommended',     5.0, '2025-10-23 15:00:00', 204, 4,  NULL),
(5,  'Desserts were very good',           4.2, '2025-10-24 16:00:00', 205, 5,  NULL),
(6,  'Delivery was very fast',            4.6, '2025-10-25 17:00:00', NULL, 6,  1),
(7,  'Polite delivery partner',           4.8, '2025-10-26 18:00:00', NULL, 7,  2),
(8,  'Late delivery but good behavior',   3.9, '2025-10-27 19:00:00', NULL, 8,  3),
(9,  'Package handled carefully',         4.7, '2025-10-28 20:00:00', NULL, 9,  4),
(10, 'Delivery was delayed',              3.5, '2025-10-29 21:00:00', NULL, 10, 5);

INSERT INTO Cancellation (Cancellation_ID, Canceled_BY, Reason, Cancel_At, Refund_Eligible, Penalty_Amount, Order_ID) VALUES
(1, 1, 'Changed mind',            '2025-10-23 14:00:00', TRUE,  0,  4),
(2, 2, 'Late delivery',           '2025-10-27 18:00:00', TRUE,  0,  8),
(3, 3, 'Wrong item delivered',    '2025-10-28 19:30:00', TRUE,  0,  9),
(4, 4, 'Order placed by mistake', '2025-10-25 16:00:00', FALSE, 50, 6);

INSERT INTO Wallet (Wallet_ID, Balance, Created_At, UserID) VALUES
(1, 1000,'2025-10-01 10:00:00', 1),
(2,  800,'2025-10-01 10:10:00', 2),
(3, 1200,'2025-10-01 10:20:00', 3),
(4,  500,'2025-10-01 10:30:00', 4),
(5,  700,'2025-10-01 10:40:00', 5),
(6,  900,'2025-10-01 10:50:00', 6),
(7,  400,'2025-10-01 11:00:00', 7),
(8,  600,'2025-10-01 11:10:00', 8),
(9,  300,'2025-10-01 11:20:00', 9),
(10,1000,'2025-10-01 11:30:00',10);

INSERT INTO Wallet_Transaction (Transaction_ID, Wallet_ID, Type, Amount, Balance_After, Date_Time) VALUES
(1,  1, 'CREDIT', 500, 1500,'2025-10-20 10:00:00'),
(2,  1, 'DEBIT',  200, 1300,'2025-10-21 11:00:00'),
(3,  2, 'CREDIT', 300, 1100,'2025-10-20 10:30:00'),
(4,  2, 'DEBIT',  100, 1000,'2025-10-21 11:30:00'),
(5,  3, 'CREDIT', 400, 1600,'2025-10-22 12:00:00'),
(6,  3, 'DEBIT',  150, 1450,'2025-10-23 13:00:00'),
(7,  4, 'CREDIT', 200,  700,'2025-10-22 12:30:00'),
(8,  5, 'DEBIT',  100,  600,'2025-10-23 14:00:00'),
(9,  6, 'CREDIT', 300, 1200,'2025-10-24 15:00:00'),
(10, 7, 'DEBIT',   50,  350,'2025-10-25 16:00:00');

INSERT INTO Wallet_Topup (Transaction_ID, Status, Payment_Mode, Transaction_Ref, Date_Time) VALUES
(1, 'Success', 'UPI',        111001,'2025-10-20 10:00:00'),
(3, 'Success', 'Card',       111002,'2025-10-20 10:30:00'),
(5, 'Success', 'UPI',        111003,'2025-10-22 12:00:00'),
(7, 'Success', 'NetBanking', 111004,'2025-10-22 12:30:00'),
(9, 'Success', 'UPI',        111005,'2025-10-24 15:00:00');

INSERT INTO Notification (Notification_ID, UserID, Title, Message, Type, Is_Read, Created_At) VALUES
(1,  1, 'Order Placed',       'Your order #1 has been placed successfully.',   'OrderUpdate', TRUE,  '2025-10-20 10:30:00'),
(2,  1, 'Out for Delivery',   'Your order #1 is on the way!',                  'OrderUpdate', TRUE,  '2025-10-20 10:45:00'),
(3,  1, 'Order Delivered',    'Your order #1 has been delivered. Enjoy!',      'OrderUpdate', TRUE,  '2025-10-20 11:15:00'),
(4,  2, 'Order Placed',       'Your order #2 has been placed successfully.',   'OrderUpdate', TRUE,  '2025-10-21 11:15:00'),
(5,  4, 'Order Cancelled',    'Your order #4 has been cancelled.',             'OrderUpdate', TRUE,  '2025-10-23 14:00:00'),
(6,  4, 'Refund Initiated',   'Refund of ₹200 has been credited to wallet.',   'Refund',      FALSE, '2025-10-23 19:00:00'),
(7,  5, 'Special Offer!',     'Use SAVE20 to get 20% off your next order.',    'Promo',       FALSE, '2025-10-25 09:00:00'),
(8,  8, 'Order Cancelled',    'Your order #8 has been cancelled.',             'OrderUpdate', TRUE,  '2025-10-27 18:00:00'),
(9,  8, 'Refund Pending',     'Your refund of ₹120 is being processed.',       'Refund',      FALSE, '2025-10-27 18:30:00'),
(10, 3, 'Promo Alert',        'Weekend special: 15% off with WEEKEND15!',      'Promo',       FALSE, '2025-10-26 08:00:00');

INSERT INTO Complaint (Complaint_ID, OrderID, UserID, Issue_Type, Description, Created_At, Status, Resolved_At) VALUES
(1, 4,  4,  'Late Delivery',   'Order arrived very late',    '2025-10-23 15:00:00','Resolved','2025-10-23 18:00:00'),
(2, 6,  6,  'Wrong Item',      'Received wrong food item',   '2025-10-25 16:30:00','Resolved','2025-10-25 19:00:00'),
(3, 8,  8,  'Cold Food',       'Food was cold on arrival',   '2025-10-27 18:30:00','Pending', NULL),
(4, 9,  9,  'Missing Item',    'One item missing in order',  '2025-10-28 20:00:00','Resolved','2025-10-28 22:00:00'),
(5, 2,  2,  'Bad Quality',     'Food quality was poor',      '2025-10-21 13:00:00','Resolved','2025-10-21 16:00:00'),
(6, 10, 10, 'Packaging Issue', 'Food packaging was damaged', '2025-10-29 21:00:00','Pending', NULL);

INSERT INTO Refund (Refund_ID, OrderID, Complaint_ID, Refund_Amount, Refund_Status, Completed_At, Wallet_ID) VALUES
(1, 4,  1,    200,'Completed','2025-10-23 19:00:00', 4),
(2, 6,  2,    150,'Completed','2025-10-25 20:00:00', 6),
(3, 9,  4,    100,'Completed','2025-10-28 23:00:00', 9),
(4, 8,  3,    120,'Pending',  NULL,                  8),
(5, 10, 6,     80,'Pending',  NULL,                  10),
(6, 5,  NULL,  50,'Completed','2025-10-24 15:00:00', 5);
