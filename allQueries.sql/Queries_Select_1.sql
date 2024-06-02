SELECT Material_ID, Material_Name, Quantity_in_Stock, Supplier
FROM Raw_Materials
ORDER BY Quantity_in_Stock DESC
FETCH FIRST 10 ROWS ONLY;


