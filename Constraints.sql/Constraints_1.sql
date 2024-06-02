ALTER TABLE Raw_Materials
ADD CONSTRAINT chk_quantity CHECK (Quantity_in_Stock > 0);
