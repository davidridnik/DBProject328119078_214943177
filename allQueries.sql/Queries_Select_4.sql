SELECT t.Tool_ID, t.Tool_Name, t.Manufacture_Date, t.Status
FROM Tools t
WHERE EXTRACT(MONTH FROM t.Manufacture_Date) = 5
ORDER BY t.Status, t.Manufacture_Date;
