UPDATE Raw_Materials
SET Quantity_in_Stock = Quantity_in_Stock + 500
WHERE Quantity_in_Stock < 3000;
