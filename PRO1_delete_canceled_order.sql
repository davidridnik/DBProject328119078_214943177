CREATE OR REPLACE PROCEDURE delete_canceled_order(order_id IN INTEGER, deleted_count OUT INTEGER) AS
BEGIN
    -- מחיקת ההזמנה מבסיס הנתונים
    DELETE FROM production_orders
    WHERE production_order_id = order_id
    AND status = 'Canceled';
    
    -- ספירת כמות ההזמנות שנמחקו
    deleted_count := SQL%ROWCOUNT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        deleted_count := 0;
        DBMS_OUTPUT.PUT_LINE('Order ' || order_id || ' not found or not in Canceled status');
    WHEN OTHERS THEN
        deleted_count := 0;
        DBMS_OUTPUT.PUT_LINE('Error deleting order ' || order_id);
END delete_canceled_order;
/
