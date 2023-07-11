create or replace PROCEDURE RENTPROPERTY 
(
  P_PROPERTY_ID IN NUMBER,
  P_TENANT_ID IN NUMBER,
  P_OWNER_ID IN NUMBER,
  P_START_DATE IN DATE,
  P_END_DATE IN DATE
) AS 
  P_RENT NUMBER;
  P_STATUS VARCHAR2(2);
BEGIN
  -- Retrieve the rent value and status for the specified property_id
  SELECT RENT, status INTO P_RENT, P_STATUS FROM property WHERE property_id = P_PROPERTY_ID;
  
  -- Check if the property is available for rent based on the status
  IF P_STATUS = 'A' THEN
    -- Insert the rental details into the property_history table
    INSERT INTO property_history (property_id, tenant_id, owner_id, start_date, end_date, rent)
    VALUES (P_PROPERTY_ID, P_TENANT_ID, P_OWNER_ID, P_START_DATE, P_END_DATE, P_RENT);
    
    -- Update the status of the property to "NA"
    UPDATE property SET status = 'NA' WHERE property_id = P_PROPERTY_ID;
    
    COMMIT;
    
    -- Output statement for successful rental
    DBMS_OUTPUT.PUT_LINE('Property rented successfully.');
  ELSE
    -- Property is not available for rent
    DBMS_OUTPUT.PUT_LINE('Property is not available for rent.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END RENTPROPERTY;