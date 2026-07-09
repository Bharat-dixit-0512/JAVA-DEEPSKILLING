SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_EmployeeID IN NUMBER,
    p_Percentage IN NUMBER
) IS
    v_OldSalary NUMBER;
    v_NewSalary NUMBER;
    v_ErrorMsg VARCHAR2(4000);

    e_invalid_percentage EXCEPTION;
BEGIN
    
    IF p_Percentage IS NULL OR p_Percentage < -100 THEN
        RAISE e_invalid_percentage;
    END IF;

    SELECT Salary INTO v_OldSalary
    FROM Employees
    WHERE EmployeeID = p_EmployeeID
    FOR UPDATE;

    v_NewSalary := v_OldSalary * (1 + (p_Percentage / 100));
    
    UPDATE Employees
    SET Salary = v_NewSalary
    WHERE EmployeeID = p_EmployeeID;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated for Employee ID ' || p_EmployeeID || '. Old: $' || v_OldSalary || ', New: $' || v_NewSalary);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        v_ErrorMsg := 'Error: Employee ID ' || p_EmployeeID || ' does not exist in the database.';
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('UpdateSalary', v_ErrorMsg);
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Exception handled: ' || v_ErrorMsg);
        
    WHEN e_invalid_percentage THEN
        ROLLBACK;
        v_ErrorMsg := 'Error: Invalid salary update percentage: ' || p_Percentage;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('UpdateSalary', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Exception handled: ' || v_ErrorMsg);
        
    WHEN OTHERS THEN
        ROLLBACK;
        v_ErrorMsg := 'Unexpected error occurred for Employee ID ' || p_EmployeeID || ': ' || SQLERRM;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('UpdateSalary', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Exception handled: ' || v_ErrorMsg);
END;
/
