create or replace PROCEDURE INSERTUSER(
  p_user_id IN NUMBER,  
  p_login_cred IN VARCHAR2,
  p_password IN VARCHAR2,
  p_name IN VARCHAR2,
  p_age IN NUMBER,
  p_city IN VARCHAR2,
  p_locality IN VARCHAR2,
  p_role IN VARCHAR2
)
IS
BEGIN
  
  
  -- Insert user data into the table
  INSERT INTO users (user_id,login_cred, password, name, age, city, locality, role)
  VALUES (p_user_id,p_login_cred, p_password, p_name, p_age, p_city, p_locality, p_role);
  
  -- Create the user
  EXECUTE IMMEDIATE 'CREATE USER ' || p_login_cred || ' IDENTIFIED BY ' || p_password || ' DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp';
  
 
  
  -- Grant role to the user
  EXECUTE IMMEDIATE 'GRANT ' || p_role || ' TO ' || p_login_cred;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('User added successfully');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    RAISE;
END;