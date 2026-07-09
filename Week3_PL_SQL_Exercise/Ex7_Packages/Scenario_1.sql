SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE CustomerManagement AS
    
    PROCEDURE AddCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE,
        p_Balance IN NUMBER
    );

    PROCEDURE UpdateCustomerDetails(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE
    );

    FUNCTION GetCustomerBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
        VALUES (p_CustomerID, p_Name, p_DOB, p_Balance, SYSDATE, 'FALSE');
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('CustomerManagement: Added customer ' || p_Name || ' (ID: ' || p_CustomerID || ').');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: Customer with ID ' || p_CustomerID || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error adding customer: ' || SQLERRM);
    END AddCustomer;

    PROCEDURE UpdateCustomerDetails(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE
    ) IS
    BEGIN
        UPDATE Customers
        SET Name = p_Name,
            DOB = p_DOB,
            LastModified = SYSDATE
        WHERE CustomerID = p_CustomerID;
        
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: Customer ID ' || p_CustomerID || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement: Updated customer details for ID ' || p_CustomerID || '.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error updating customer details: ' || SQLERRM);
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_Balance NUMBER;
    BEGIN
        SELECT Balance INTO v_Balance
        FROM Customers
        WHERE CustomerID = p_CustomerID;
        
        RETURN v_Balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error: Customer ID ' || p_CustomerID || ' not found.');
            RETURN NULL;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('CustomerManagement Error fetching customer balance: ' || SQLERRM);
            RETURN NULL;
    END GetCustomerBalance;

END CustomerManagement;
/
