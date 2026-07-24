SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_Department IN VARCHAR2,
    p_BonusPercentage IN NUMBER
) IS
    v_UpdatedCount NUMBER := 0;
    e_invalid_bonus EXCEPTION;
BEGIN
    
    IF p_BonusPercentage IS NULL OR p_BonusPercentage < 0 THEN
        RAISE e_invalid_bonus;
    END IF;

    UPDATE Employees
    SET Salary = Salary * (1 + (p_BonusPercentage / 100))
    WHERE Department = p_Department;
    
    v_UpdatedCount := SQL%ROWCOUNT;
    
    COMMIT;
    
    IF v_UpdatedCount > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Bonus applied successfully.');
        DBMS_OUTPUT.PUT_LINE('Updated salary for ' || v_UpdatedCount || ' employee(s) in the ' || p_Department || ' department.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees found in the ' || p_Department || ' department. No updates made.');
    END IF;

EXCEPTION
    WHEN e_invalid_bonus THEN
        DBMS_OUTPUT.PUT_LINE('Error: Bonus percentage cannot be negative or null: ' || p_BonusPercentage);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error while updating employee bonuses: ' || SQLERRM);
END;
/
