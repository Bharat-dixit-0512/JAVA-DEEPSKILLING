SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_SourceAccountID IN NUMBER,
    p_DestAccountID IN NUMBER,
    p_Amount IN NUMBER
) IS
    v_SrcCustomerID NUMBER;
    v_DestCustomerID NUMBER;
    v_SrcBalance NUMBER;
    v_DestBalance NUMBER;
    v_TxnID NUMBER;
    v_ErrorMsg VARCHAR2(4000);

    e_insufficient_funds EXCEPTION;
    e_invalid_amount EXCEPTION;
    e_same_account EXCEPTION;
BEGIN
    
    IF p_Amount <= 0 THEN
        RAISE e_invalid_amount;
    END IF;

    IF p_SourceAccountID = p_DestAccountID THEN
        RAISE e_same_account;
    END IF;

    BEGIN
        SELECT CustomerID, Balance INTO v_SrcCustomerID, v_SrcBalance
        FROM Accounts
        WHERE AccountID = p_SourceAccountID
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_ErrorMsg := 'Source Account ID ' || p_SourceAccountID || ' does not exist.';
            RAISE;
    END;

    BEGIN
        SELECT CustomerID, Balance INTO v_DestCustomerID, v_DestBalance
        FROM Accounts
        WHERE AccountID = p_DestAccountID
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_ErrorMsg := 'Destination Account ID ' || p_DestAccountID || ' does not exist.';
            RAISE;
    END;

    IF v_SrcBalance < p_Amount THEN
        RAISE e_insufficient_funds;
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
    DBMS_OUTPUT.PUT_LINE('Successfully transferred $' || p_Amount || ' from Account ' || p_SourceAccountID || ' to Account ' || p_DestAccountID);

EXCEPTION
    WHEN e_invalid_amount THEN
        ROLLBACK;
        v_ErrorMsg := 'Transfer amount must be greater than zero. Attempted amount: ' || p_Amount;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('SafeTransferFunds', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error logged: ' || v_ErrorMsg);
        
    WHEN e_same_account THEN
        ROLLBACK;
        v_ErrorMsg := 'Source and destination accounts must be different. ID: ' || p_SourceAccountID;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('SafeTransferFunds', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error logged: ' || v_ErrorMsg);
        
    WHEN e_insufficient_funds THEN
        ROLLBACK;
        v_ErrorMsg := 'Insufficient funds in Account ' || p_SourceAccountID || '. Current balance: $' || v_SrcBalance || ', Requested: $' || p_Amount;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('SafeTransferFunds', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error logged: ' || v_ErrorMsg);
        
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('SafeTransferFunds', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error logged: ' || v_ErrorMsg);
        
    WHEN OTHERS THEN
        ROLLBACK;
        v_ErrorMsg := 'Unexpected error occurred: ' || SQLERRM;
        INSERT INTO ErrorLog (ProcedureName, ErrorMessage)
        VALUES ('SafeTransferFunds', v_ErrorMsg);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error logged: ' || v_ErrorMsg);
END;
/
