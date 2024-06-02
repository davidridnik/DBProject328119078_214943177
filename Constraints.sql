-- מונע כניסת ערכים שליליים לכמות החומר הגולמי במלאי
ALTER TABLE Raw_Materials
ADD CONSTRAINT chk_quantity CHECK (Quantity_in_Stock > 0);

--מגדיר ערך ברירת המחדל עבור מצב המכונות כאשר הערך לא מוגדר במפורש
ALTER TABLE Machines
MODIFY Status varchar2(100) DEFAULT 'Active';

-- בודק שתאריך ההתחלה של הזמנת הייצור לא יהיה מאוחר יותר מתאריך הסיום
ALTER TABLE Production_Orders
ADD CONSTRAINT chk_start_date CHECK (Start_Date <= Due_Date);

