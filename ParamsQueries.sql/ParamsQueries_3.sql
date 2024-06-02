SELECT Warehouse_ID, Warehouse_Location, Capacity, Current_Quantity
FROM Warehouses
WHERE Capacity > &capacity;
