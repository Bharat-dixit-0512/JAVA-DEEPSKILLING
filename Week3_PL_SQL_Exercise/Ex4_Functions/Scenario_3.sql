SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_AccountID IN NUMBER,
    p_Amount IN NUMBER
) RETURN BOOLEAN IS
    v_Balance NUMBER;
BEGIN
    
    IF p_Amount IS NULL OR p_Amount < 0 THEN
        RETURN FALSE;
    END IF;

    SELECT Balance INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_AccountID;

    IF v_Balance >= p_Amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('HasSufficientBalance: Account ID ' || p_AccountID || ' not found.');
        RETURN FALSE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('HasSufficientBalance error: ' || SQLERRM);
        RETURN FALSE;
END;
/
