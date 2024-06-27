BEGIN
  DECLARE
    v_total_orders NUMBER;
    v_supplier_info VARCHAR2(4000);
  BEGIN
    v_total_orders := 0;
    FOR material IN (SELECT material_id FROM RAW_MATERIALS) LOOP
      v_total_orders := v_total_orders + check_and_order_material(material.material_id);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total new orders: ' || v_total_orders);
    
    v_supplier_info := '';
    FOR material IN (SELECT material_id FROM RAW_MATERIALS) LOOP
      analyze_suppliers(material.material_id);
     
    END LOOP;
    
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
  END;
END;
/
