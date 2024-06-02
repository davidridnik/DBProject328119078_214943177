ALTER TABLE Production_Orders
ADD CONSTRAINT chk_start_date CHECK (Start_Date <= Due_Date);
