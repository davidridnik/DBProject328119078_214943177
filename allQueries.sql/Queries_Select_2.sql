SELECT m.Machine_ID, m.Machine_Name, mm.Maintenance_Date, mm.Maintenance_Type
FROM Machines m
JOIN Machine_Maintenance mm ON m.Maintenance_ID = mm.Maintenance_ID
WHERE mm.Maintenance_Date < SYSDATE AND mm.Status <> 'Completed';
