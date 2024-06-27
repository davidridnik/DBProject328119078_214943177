CREATE OR REPLACE PROCEDURE analyze_suppliers(p_material_id IN NUMBER) IS
    v_supplier VARCHAR2(100);
    v_quantity NUMBER;
BEGIN
    SELECT supplier, quantity_in_stock
    INTO v_supplier, v_quantity
    FROM RAW_MATERIALS
    WHERE material_id = p_material_id;

    DBMS_OUTPUT.PUT_LINE('Supplier: ' || v_supplier || ', Material: ' || p_material_id || ', Quantity: ' || v_quantity);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in analyze_suppliers: ' || SQLERRM);
END;
/
