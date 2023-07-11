create or replace PROCEDURE SEARCHPROPERTY (P_CITY IN VARCHAR2)
AS
  CURSOR property_cur IS
    SELECT * FROM property WHERE city = P_CITY;
  property_rec property_cur%ROWTYPE;
  v_status property.status%TYPE;
  v_rent property.rent%TYPE;
BEGIN
  OPEN property_cur;
  
  -- Fetch and display all properties in the specified city
  LOOP
    FETCH property_cur INTO property_rec;
    EXIT WHEN property_cur%NOTFOUND;
    
    v_status := property_rec.status;
    v_rent := property_rec.rent;
    
    DBMS_OUTPUT.PUT_LINE('Property ID: ' || property_rec.property_id);
    DBMS_OUTPUT.PUT_LINE('Owner ID: ' || property_rec.owner_id);
    DBMS_OUTPUT.PUT_LINE('Rent: ' || v_rent);
    DBMS_OUTPUT.PUT_LINE('City: ' || property_rec.city);
    DBMS_OUTPUT.PUT_LINE('Locality: ' || property_rec.locality);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_status);
    
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  END LOOP;
  
  CLOSE property_cur;
EXCEPTION
  WHEN OTHERS THEN
    IF property_cur%ISOPEN THEN
      CLOSE property_cur;
    END IF;
    RAISE;
END SEARCHPROPERTY;