SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE AccountOperations AS
    
    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_InitialBalance IN NUMBER
    );

    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    );

    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_InitialBalance IN NUMBER
    ) IS
        v_CustExists NUMBER;
    BEGIN
        
        SELECT COUNT(*) INTO v_CustExists 
        FROM Customers 
        WHERE CustomerID = p_CustomerID;

        IF v_CustExists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: Customer ID ' || p_CustomerID || ' does not exist. Cannot open account.');
            RETURN;
        END IF;

        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_AccountID, p_CustomerID, p_AccountType, p_InitialBalance, SYSDATE);

        UPDATE Customers
        SET Balance = (SELECT COALESCE(SUM(Balance), 0) FROM Accounts WHERE CustomerID = p_CustomerID),
            LastModified = SYSDATE
        WHERE CustomerID = p_CustomerID;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('AccountOperations: Successfully opened account ' || p_AccountID || 
                             ' (' || p_AccountType || ') for Customer ID ' || p_CustomerID || '.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: Account ID ' || p_AccountID || ' already exists.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error opening account: ' || SQLERRM);
    END OpenAccount;

    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    ) IS
        v_CustomerID NUMBER;
        v_AccExists NUMBER;
    BEGIN
        
        SELECT CustomerID INTO v_CustomerID 
        FROM Accounts 
        WHERE AccountID = p_AccountID;

        DELETE FROM Accounts 
        WHERE AccountID = p_AccountID;

        UPDATE Customers
        SET Balance = (SELECT COALESCE(SUM(Balance), 0) FROM Accounts WHERE CustomerID = v_CustomerID),
            LastModified = SYSDATE
        WHERE CustomerID = v_CustomerID;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('AccountOperations: Successfully closed Account ID ' || p_AccountID || '.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: Account ID ' || p_AccountID || ' not found.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error closing account: ' || SQLERRM);
    END CloseAccount;

    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_TotalBalance NUMBER := 0;
        v_CustExists NUMBER;
    BEGIN
        
        SELECT COUNT(*) INTO v_CustExists 
        FROM Customers 
        WHERE CustomerID = p_CustomerID;

        IF v_CustExists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error: Customer ID ' || p_CustomerID || ' not found.');
            RETURN NULL;
        END IF;

        SELECT COALESCE(SUM(Balance), 0) INTO v_TotalBalance
        FROM Accounts
        WHERE CustomerID = p_CustomerID;

        RETURN v_TotalBalance;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('AccountOperations Error calculating total balance: ' || SQLERRM);
            RETURN NULL;
    END GetTotalBalance;

END AccountOperations;
/
