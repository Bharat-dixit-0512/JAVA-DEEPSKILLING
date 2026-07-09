SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_SourceAccountID IN NUMBER,
    p_DestAccountID IN NUMBER,
    p_Amount IN NUMBER
) IS
    v_SrcBalance NUMBER;
    v_SrcCustomerID NUMBER;
    v_DestCustomerID NUMBER;
    v_TxnID NUMBER;
BEGIN
    
    IF p_Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Transfer amount must be positive. Amount: ' || p_Amount);
    END IF;

    BEGIN
        SELECT Balance, CustomerID INTO v_SrcBalance, v_SrcCustomerID
        FROM Accounts
        WHERE AccountID = p_SourceAccountID
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Source account ID ' || p_SourceAccountID || ' does not exist.');
    END;

    BEGIN
        SELECT CustomerID INTO v_DestCustomerID
        FROM Accounts
        WHERE AccountID = p_DestAccountID
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Destination account ID ' || p_DestAccountID || ' does not exist.');
    END;

    IF v_SrcBalance < p_Amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in source account ID ' || p_SourceAccountID || 
                                '. Available: $' || v_SrcBalance || ', Requested: $' || p_Amount);
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_Amount,
        LastModified = SYSDATE
    WHERE AccountID = p_SourceAccountID;

    UPDATE Accounts
    SET Balance = Balance + p_Amount,
        LastModified = SYSDATE
    WHERE AccountID = p_DestAccountID;

    UPDATE Customers
    SET Balance = Balance - p_Amount,
        LastModified = SYSDATE
    WHERE CustomerID = v_SrcCustomerID;

    UPDATE Customers
    SET Balance = Balance + p_Amount,
        LastModified = SYSDATE
    WHERE CustomerID = v_DestCustomerID;

    SELECT COALESCE(MAX(TransactionID), 0) + 1 INTO v_TxnID FROM Transactions;
    
    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (v_TxnID, p_SourceAccountID, SYSDATE, p_Amount, 'Withdrawal');

    INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
    VALUES (v_TxnID + 1, p_DestAccountID, SYSDATE, p_Amount, 'Deposit');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully transferred $' || p_Amount || ' from Account ID ' || p_SourceAccountID || ' to Account ID ' || p_DestAccountID || '.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        
        IF SQLCODE BETWEEN -20999 AND -20000 THEN
            RAISE;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Database error during transfer: ' || SQLERRM);
        END IF;
END;
/
