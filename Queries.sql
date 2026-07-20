-- Q1: Menu items per category with price stats (Restaurant 201)
SELECT
    MC.Category_Name,
    COUNT(MI.Item_ID)       AS Item_Count,
    ROUND(AVG(MI.Price), 2) AS Avg_Price,
    MIN(MI.Price)           AS Min_Price,
    MAX(MI.Price)           AS Max_Price
FROM Menu_Item MI
JOIN Menu_Category MC
    ON MI.Category_Name   = MC.Category_Name
   AND MI.Restaurant_ID   = MC.Restaurant_ID
WHERE MI.Restaurant_ID = 201
  AND MI.Is_Available  = TRUE
GROUP BY MC.Category_Name
ORDER BY Avg_Price DESC;


-- Q2: Most used payment method
SELECT
    Mode              AS Payment_Method,
    COUNT(Order_ID)   AS Times_Used,
    SUM(Amount)       AS Total_Revenue
FROM Payment
WHERE Status = 'Success'
GROUP BY Mode
ORDER BY Times_Used DESC;


-- Q3: Orders placed by users with wallet balance below ₹500
SELECT
    O.OrderID,
    U.User_Name,
    W.Balance    AS Wallet_Balance,
    O.Date_Time  AS Order_Time,
    O.Total_Amount
FROM Orders O
JOIN User   U ON O.UserID  = U.UserID
JOIN Wallet W ON U.UserID  = W.UserID
WHERE W.Balance < 500
ORDER BY W.Balance ASC;


-- Q4: Total revenue per restaurant
SELECT
    R.Resto_Name                      AS Restaurant,
    SUM(OI.Quantity * OI.Price)       AS Gross_Revenue,
    COUNT(DISTINCT O.OrderID)         AS Total_Orders,
    ROUND(AVG(OI.Quantity * OI.Price),2) AS Avg_Order_Value
FROM Orders O
JOIN Order_Item OI ON O.OrderID      = OI.OrderID
JOIN Menu_Item  MI ON OI.Item_ID     = MI.Item_ID
JOIN Restaurant R  ON MI.Restaurant_ID = R.Restaurant_ID
WHERE O.Order_Status != 'Cancelled'
GROUP BY R.Restaurant_ID, R.Resto_Name
ORDER BY Gross_Revenue DESC;


-- Q5: Top rated restaurants
SELECT
    R.Resto_Name,
    R.Rating,
    R.Total_Reviews,
    R.Avg_Delivery_Time AS Est_Delivery_Mins
FROM Restaurant R
WHERE R.Restaurant_Status = TRUE
ORDER BY R.Rating DESC
LIMIT 5;


-- Q6: Average delivery time per partner (minutes)
SELECT
    DP.Name                                                              AS Partner_Name,
    DP.City,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, D.Pickup_Time, D.Delivery_Time)),1) AS Avg_Delivery_Mins,
    COUNT(D.Delivery_ID)                                                 AS Total_Deliveries,
    DP.Rating                                                            AS Partner_Rating
FROM Delivery D
JOIN Delivery_Partner DP ON D.Partner_ID = DP.Partner_ID
WHERE D.Delivery_Time IS NOT NULL
GROUP BY DP.Partner_ID, DP.Name, DP.City, DP.Rating
ORDER BY Avg_Delivery_Mins ASC;


-- Q7: Pending complaints with user details
SELECT
    C.Complaint_ID,
    C.Issue_Type,
    C.Description,
    U.User_Name,
    U.Phone_No,
    O.Date_Time  AS Order_Time,
    C.Created_At AS Complaint_Time
FROM Complaint C
JOIN Orders O ON C.OrderID = O.OrderID
JOIN User   U ON C.UserID  = U.UserID
WHERE C.Status = 'Pending'
ORDER BY C.Created_At ASC;


-- Q8: Users with most orders and total spend
SELECT
    U.User_Name,
    COUNT(O.OrderID)   AS Total_Orders,
    SUM(O.Total_Amount) AS Total_Spent,
    W.Balance           AS Current_Wallet_Balance
FROM User U
JOIN Orders O  ON U.UserID = O.UserID
JOIN Wallet W  ON U.UserID = W.UserID
WHERE O.Order_Status != 'Cancelled'
GROUP BY U.UserID, U.User_Name, W.Balance
ORDER BY Total_Spent DESC;


-- Q9: Refund summary by status
SELECT
    Refund_Status,
    COUNT(Refund_ID)   AS Refund_Count,
    SUM(Refund_Amount) AS Total_Amount
FROM Refund
GROUP BY Refund_Status;


-- Q10: Top 5 most ordered menu items
SELECT
    MI.Item_Name,
    MI.Is_Veg,
    MI.Price,
    SUM(OI.Quantity) AS Total_Ordered,
    MI.Rating        AS Item_Rating
FROM Order_Item OI
JOIN Menu_Item MI ON OI.Item_ID = MI.Item_ID
GROUP BY MI.Item_ID, MI.Item_Name, MI.Is_Veg, MI.Price, MI.Rating
ORDER BY Total_Ordered DESC
LIMIT 5;


-- Q11: Monthly revenue trend
SELECT
    DATE_FORMAT(O.Date_Time, '%Y-%m') AS Month,
    COUNT(O.OrderID)                  AS Total_Orders,
    SUM(O.Total_Amount)               AS Total_Revenue
FROM Orders O
WHERE O.Order_Status != 'Cancelled'
GROUP BY DATE_FORMAT(O.Date_Time, '%Y-%m')
ORDER BY Month ASC;


-- Q12: Veg vs Non-Veg order split
SELECT
    CASE WHEN MI.Is_Veg = TRUE THEN 'Veg' ELSE 'Non-Veg' END AS Food_Type,
    COUNT(OI.Item_ID)        AS Items_Ordered,
    SUM(OI.Quantity)         AS Total_Quantity
FROM Order_Item OI
JOIN Menu_Item MI ON OI.Item_ID = MI.Item_ID
GROUP BY MI.Is_Veg;


-- Q13: City-wise order distribution
SELECT
    A.City,
    COUNT(O.OrderID)     AS Total_Orders,
    SUM(O.Total_Amount)  AS Revenue
FROM Orders O
JOIN Address A ON O.Add_ID = A.Add_ID
WHERE O.Order_Status != 'Cancelled'
GROUP BY A.City
ORDER BY Total_Orders DESC;


-- Q14: Coupon usage and savings
SELECT
    C.Coupon_Code,
    C.Description,
    C.Used_Count,
    C.Max_Uses,
    ROUND((C.Used_Count / C.Max_Uses) * 100, 1) AS Usage_Pct
FROM Coupon C
ORDER BY C.Used_Count DESC;


-- Q15: Unread notifications per user
SELECT
    U.User_Name,
    COUNT(N.Notification_ID) AS Unread_Count
FROM Notification N
JOIN User U ON N.UserID = U.UserID
WHERE N.Is_Read = FALSE
GROUP BY U.UserID, U.User_Name
ORDER BY Unread_Count DESC;


-- Q16: Live order tracking — full status timeline for an order
SELECT
    O.OrderID,
    U.User_Name,
    OSL.Status,
    OSL.Changed_At,
    OSL.Note
FROM Order_Status_Log OSL
JOIN Orders O ON OSL.OrderID = O.OrderID
JOIN User   U ON O.UserID    = U.UserID
WHERE O.OrderID = 1
ORDER BY OSL.Changed_At ASC;


-- Q17: Available delivery partners in a city
SELECT
    Partner_ID,
    Name,
    Phone_No,
    Vehicle_No,
    Rating,
    Total_Deliveries
FROM Delivery_Partner
WHERE Is_Available = TRUE
  AND City = 'Ahmedabad'
ORDER BY Rating DESC;


-- Q18: Cancelled orders with refund status
SELECT
    O.OrderID,
    U.User_Name,
    C.Reason          AS Cancel_Reason,
    C.Cancel_At,
    R.Refund_Amount,
    R.Refund_Status
FROM Cancellation C
JOIN Orders O  ON C.Order_ID   = O.OrderID
JOIN User   U  ON O.UserID     = U.UserID
LEFT JOIN Refund R ON R.OrderID = O.OrderID
ORDER BY C.Cancel_At DESC;
