CREATE OR REPLACE FUNCTION check_and_order_material(p_material_id IN NUMBER) 
RETURN NUMBER IS
    v_quantity_in_stock NUMBER;
    v_capacity NUMBER;
    v_current_quantity NUMBER;
    v_order_quantity NUMBER;
    v_warehouse_id NUMBER;
    v_new_order_id NUMBER;
    v_tool_id NUMBER;
    v_ordered NUMBER := 0;
BEGIN
    -- Get current stock
    SELECT quantity_in_stock INTO v_quantity_in_stock
    FROM RAW_MATERIALS
    WHERE material_id = p_material_id;

    -- Get warehouse info
    SELECT warehouse_id, capacity, current_quantity 
    INTO v_warehouse_id, v_capacity, v_current_quantity
    FROM WAREHOUSES
    WHERE warehouse_id = (
        SELECT MIN(warehouse_id) 
        FROM WAREHOUSES 
        WHERE current_quantity < capacity
    );

    -- Check if stock is below 30%
    IF v_quantity_in_stock < (0.3 * v_capacity) THEN
        -- Calculate order quantity to reach 90%
        v_order_quantity := ROUND(0.9 * v_capacity) - v_quantity_in_stock;
        
        -- Create new production order
        SELECT NVL(MAX(production_order_id), 0) + 1 INTO v_new_order_id FROM PRODUCTION_ORDERS;
        SELECT MIN(tool_id) INTO v_tool_id FROM TOOLS WHERE status = 'Available';
        
        INSERT INTO PRODUCTION_ORDERS (production_order_id, tool_id, quantity, start_date, due_date, status)
        VALUES (v_new_order_id, v_tool_id, v_order_quantity, SYSDATE, SYSDATE + 30, 'In Progress');

        -- Update warehouse
        UPDATE WAREHOUSES
        SET current_quantity = current_quantity + v_order_quantity
        WHERE warehouse_id = v_warehouse_id;

        -- Update raw materials
        UPDATE RAW_MATERIALS
        SET quantity_in_stock = quantity_in_stock + v_order_quantity
        WHERE material_id = p_material_id;

        v_ordered := 1;
    END IF;

    RETURN v_ordered;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in check_and_order_material: ' || SQLERRM);
        RETURN 0;
END;
/
