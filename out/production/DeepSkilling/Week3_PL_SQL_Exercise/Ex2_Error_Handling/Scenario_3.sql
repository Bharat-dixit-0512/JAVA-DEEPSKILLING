SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_CustomerID IN NUMBER,
    p_Name IN VARCHAR2,
    p_DOB IN DATE,
    p_Balance IN NUMBER
) IS
    v_ErrorMsg VARCHAR2(4000);
BEGIN
    
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
    VALUES (p_CustomerID, p_Name, p_DOB, p_Balance, SYSDATE, 'FALSE');
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully inserted new customer: ' || p_Name || ' (ID: ' || p_CustomerID || ').');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        v_ErrorMsg := 'Error: Customer with ID ' || p_CustomerID || ' already exists. Integrity constraint violated.';
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('AddNewCustomer', v_ErrorMsg);
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Exception handled: ' || v_ErrorMsg);
        
    WHEN OTHERS THEN
        ROLLBACK;
        v_ErrorMsg := 'Unexpected error occurred while inserting customer ID ' || p_CustomerID || ': ' || SQLERRM;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('AddNewCustomer', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Exception handled: ' || v_ErrorMsg);
END;
/
