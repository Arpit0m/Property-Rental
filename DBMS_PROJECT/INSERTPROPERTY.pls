create or replace PROCEDURE INSERTPROPERTY(
    p_property_id IN NUMBER,
    p_owner_id IN NUMBER,
    p_rent IN NUMBER,
    p_city IN VARCHAR2,
    p_locality IN VARCHAR2,
    p_status IN VARCHAR2
) AS
BEGIN
    -- Attempt the insert
    INSERT INTO praadmin.property (property_id, owner_id, rent, city, locality,status)
    VALUES (p_property_id, p_owner_id, p_rent, p_city, p_locality,p_status);
    
    -- Commit the transaction
    COMMIT;
    
    -- Print success message
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback the transaction
        ROLLBACK;
        
        -- Print the error message
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END INSERTPROPERTY;