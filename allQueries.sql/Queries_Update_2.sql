UPDATE Tools
SET Status = 'In Repair'
WHERE Tool_ID IN (
  SELECT Tool_ID
  FROM Production_Orders
  WHERE Start_Date < TO_DATE('2023-01-01', 'YYYY-MM-DD')
);
