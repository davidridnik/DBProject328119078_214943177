DECLARE
    ord_id INTEGER;
    current_status VARCHAR2(100);
    deleted_orders INTEGER := 0;
BEGIN
    -- עבור על כל ההזמנות במערכת
    FOR ord_rec IN (SELECT production_order_id, status FROM production_orders) LOOP
        ord_id := ord_rec.production_order_id;
        current_status := ord_rec.status;
        
        -- בדיקת מצב ההזמנה ועדכון אם הזמן עבר
        IF current_status = 'Processing' THEN
            DBMS_OUTPUT.PUT_LINE(check_and_update_order_status(ord_id));
        END IF;
        
        -- מחיקת הזמנות שבוטלו
        IF current_status = 'Canceled' THEN
            delete_canceled_order(ord_id, deleted_orders);
        END IF;
    END LOOP;
    
    -- פלט סופי של כמות ההזמנות שנמחקו
    DBMS_OUTPUT.PUT_LINE('Total canceled orders deleted: ' || deleted_orders);
END;
/
