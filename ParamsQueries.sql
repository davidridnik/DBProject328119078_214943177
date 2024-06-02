--שליפת פרטי הזמנות ייצור עם תאריך יעד לאחר תאריך מסוים
SELECT po.Production_Order_ID, po.Tool_ID, po.Quantity, po.Start_Date, po.Due_Date, po.Status, t.Tool_Name
FROM Production_Orders po
JOIN Tools t ON po.Tool_ID = t.Tool_ID
WHERE po.Due_Date > TO_DATE('&due_date', 'YYYY-MM-DD');

--שליפת מכונות עם תחזוקה מתוכננת בטווח תאריכים נתון
SELECT m.Machine_ID, m.Machine_Name, mm.Maintenance_Date, mm.Maintenance_Type, mm.Status
FROM Machines m
JOIN Machine_Maintenance mm ON m.Maintenance_ID = mm.Maintenance_ID
WHERE mm.Maintenance_Date BETWEEN TO_DATE('&start_date', 'YYYY-MM-DD') AND TO_DATE('&end_date', 'YYYY-MM-DD');

-- שליפת פרטי מחסנים בעלי קיבולת גדולה מיכולת נתונה
SELECT Warehouse_ID, Warehouse_Location, Capacity, Current_Quantity
FROM Warehouses
WHERE Capacity > &capacity;

-- שליפת פרטי חומרי גלם שנמצאים במלאי פחות מכמות מסוימת
SELECT Material_ID, Material_Name, Quantity_in_Stock, Supplier
FROM Raw_Materials
WHERE Quantity_in_Stock < &max_quantity;
