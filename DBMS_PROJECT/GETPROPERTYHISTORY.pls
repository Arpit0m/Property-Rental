create or replace PROCEDURE GETPROPERTYHISTORY(
  p_property_id IN NUMBER
)
IS
BEGIN
  -- List all property history records for the given property ID
  FOR history_rec IN (SELECT * FROM property_history WHERE property_id = p_property_id)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Property ID: ' || history_rec.property_id);
    DBMS_OUTPUT.PUT_LINE('Tenant ID: ' || history_rec.tenant_id);
    DBMS_OUTPUT.PUT_LINE('Owner ID: ' || history_rec.owner_id);
    DBMS_OUTPUT.PUT_LINE('Start Date: ' || history_rec.start_date);
    DBMS_OUTPUT.PUT_LINE('End Date: ' || history_rec.end_date);
    DBMS_OUTPUT.PUT_LINE('Rent: ' || history_rec.rent);
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No property history records found for Property ID: ' || p_property_id);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;