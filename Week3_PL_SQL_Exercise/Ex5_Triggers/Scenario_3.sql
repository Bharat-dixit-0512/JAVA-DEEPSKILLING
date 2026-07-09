SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_Balance NUMBER;
BEGIN
    
    IF :NEW.TransactionType = 'Deposit' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Invalid Transaction: Deposit amount must be greater than zero. Attempted amount: ' || :NEW.Amount);
        END IF;

    ELSIF :NEW.TransactionType = 'Withdrawal' THEN
        
        SELECT Balance INTO v_Balance
        FROM Accounts
        WHERE AccountID = :NEW.AccountID;
        
        IF :NEW.Amount > v_Balance THEN
            RAISE_APPLICATION_ERROR(-20005, 'Invalid Transaction: Withdrawal amount $' || :NEW.Amount || 
                                   ' exceeds current account balance of $' || v_Balance);
        END IF;

        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'Invalid Transaction: Withdrawal amount must be greater than zero. Attempted amount: ' || :NEW.Amount);
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20008, 'Invalid Transaction: Account ID ' || :NEW.AccountID || ' does not exist.');
    WHEN OTHERS THEN
        
        IF SQLCODE BETWEEN -20999 AND -20000 THEN
            RAISE;
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Error in CheckTransactionRules trigger: ' || SQLERRM);
        END IF;
END;
/
