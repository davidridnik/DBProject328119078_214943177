SELECT po.Production_Order_ID, po.Tool_ID, po.Quantity, po.Start_Date, po.Due_Date, po.Status, t.Tool_Name
FROM Production_Orders po
JOIN Tools t ON po.Tool_ID = t.Tool_ID
WHERE po.Due_Date > TO_DATE('&due_date', 'YYYY-MM-DD');
