SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    
    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    );

    PROCEDURE UpdateEmployeeDetails(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2
    );

    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_EmployeeID, p_Name, p_Position, p_Salary, p_Department, p_HireDate);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('EmployeeManagement: Successfully hired employee ' || p_Name || ' (ID: ' || p_EmployeeID || ').');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: Employee with ID ' || p_EmployeeID || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error hiring employee: ' || SQLERRM);
    END HireEmployee;

    PROCEDURE UpdateEmployeeDetails(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Employees
        SET Name = p_Name,
            Position = p_Position,
            Salary = p_Salary,
            Department = p_Department
        WHERE EmployeeID = p_EmployeeID;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: Employee ID ' || p_EmployeeID || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement: Updated details for employee ID ' || p_EmployeeID || '.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error updating employee details: ' || SQLERRM);
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER IS
        v_MonthlySalary NUMBER;
    BEGIN
        SELECT Salary INTO v_MonthlySalary
        FROM Employees
        WHERE EmployeeID = p_EmployeeID;

        RETURN v_MonthlySalary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error: Employee ID ' || p_EmployeeID || ' not found.');
            RETURN NULL;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EmployeeManagement Error calculating annual salary: ' || SQLERRM);
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/
