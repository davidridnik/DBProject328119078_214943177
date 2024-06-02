SELECT m.Machine_ID, m.Machine_Name, mm.Maintenance_Date, mm.Maintenance_Type, mm.Status
FROM Machines m
JOIN Machine_Maintenance mm ON m.Maintenance_ID = mm.Maintenance_ID
WHERE mm.Maintenance_Date BETWEEN TO_DATE('&start_date', 'YYYY-MM-DD') AND TO_DATE('&end_date', 'YYYY-MM-DD');
