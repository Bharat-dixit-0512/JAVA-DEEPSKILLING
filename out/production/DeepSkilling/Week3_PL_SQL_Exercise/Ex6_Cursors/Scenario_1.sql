SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR GenerateMonthlyStatements IS
        SELECT c.CustomerID,
               c.Name AS CustomerName,
               a.AccountID,
               a.AccountType,
               t.TransactionID,
               t.TransactionDate,
               t.Amount,
               t.TransactionType
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE t.TransactionDate >= TRUNC(SYSDATE, 'MM')
          AND t.TransactionDate < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)
        ORDER BY c.CustomerID, a.AccountID, t.TransactionDate;
        
    v_PrevCustomerID Customers.CustomerID%TYPE := -1;
    v_PrevAccountID Accounts.AccountID%TYPE := -1;
    v_RecordCount NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================================================');
    DBMS_OUTPUT.PUT_LINE('                 BANK MONTHLY STATEMENTS: ' || TO_CHAR(SYSDATE, 'MMMM YYYY'));
    DBMS_OUTPUT.PUT_LINE('========================================================================');

    FOR r_stmt IN GenerateMonthlyStatements LOOP
        v_RecordCount := v_RecordCount + 1;

        IF r_stmt.CustomerID <> v_PrevCustomerID THEN
            IF v_PrevCustomerID <> -1 THEN
                DBMS_OUTPUT.PUT_LINE('
            END IF;
            DBMS_OUTPUT.PUT_LINE('Customer: ' || r_stmt.CustomerName || ' (ID: ' || r_stmt.CustomerID || ')');
            v_PrevCustomerID := r_stmt.CustomerID;
            v_PrevAccountID := -1; 
        END IF;

        IF r_stmt.AccountID <> v_PrevAccountID THEN
            DBMS_OUTPUT.PUT_LINE('  Account ID: ' || r_stmt.AccountID || ' [' || r_stmt.AccountType || ']');
            v_PrevAccountID := r_stmt.AccountID;
        END IF;

        DBMS_OUTPUT.PUT_LINE('    - Txn ID: ' || LPAD(r_stmt.TransactionID, 5) || 
                             ' | Date: ' || TO_CHAR(r_stmt.TransactionDate, 'YYYY-MM-DD') || 
                             ' | Type: ' || RPAD(r_stmt.TransactionType, 10) || 
                             ' | Amount: $' || TO_CHAR(r_stmt.Amount, '999,999.99'));
    END LOOP;

    IF v_RecordCount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No transactions recorded for the current month.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('========================================================================');
    END IF;
END;
/
