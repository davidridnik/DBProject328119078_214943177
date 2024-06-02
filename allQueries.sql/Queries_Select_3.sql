SELECT w.Warehouse_ID, w.Warehouse_Location, w.Capacity, w.Current_Quantity, 
       ROUND((w.Current_Quantity / w.Capacity) * 100, 2) AS Occupancy_Percentage
FROM Warehouses w
WHERE w.Current_Quantity > w.Capacity / 2
ORDER BY Occupancy_Percentage DESC;
