DELETE FROM Raw_Materials
WHERE Supplier IN (
  SELECT Supplier
  FROM Raw_Materials
  WHERE Material_ID IN (
    SELECT Material_ID
    FROM Raw_Materials rm
    LEFT JOIN Production_Orders po ON rm.Material_ID = po.Tool_ID
    WHERE po.Start_Date < ADD_MONTHS(SYSDATE, -24)
  )
);
