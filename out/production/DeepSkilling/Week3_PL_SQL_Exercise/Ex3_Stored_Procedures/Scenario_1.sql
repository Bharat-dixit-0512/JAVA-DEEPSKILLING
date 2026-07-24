SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_UpdatedCount NUMBER := 0;
BEGIN
    
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';
    
    v_UpdatedCount := SQL%ROWCOUNT;

    UPDATE Customers c
    SET Balance = (
        SELECT COALESCE(SUM(Balance), 0) 
        FROM Accounts a 
        WHERE a.CustomerID = c.CustomerID
    ),
    LastModified = SYSDATE
    WHERE c.CustomerID IN (
        SELECT DISTINCT CustomerID 
        FROM Accounts 
        WHERE AccountType = 'Savings'
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest of 1% processed successfully.');
    DBMS_OUTPUT.PUT_LINE('Number of Savings accounts updated: ' || v_UpdatedCount);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error while processing monthly interest: ' || SQLERRM);
END;
/
