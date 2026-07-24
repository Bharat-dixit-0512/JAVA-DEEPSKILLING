SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR ApplyAnnualFee IS
        SELECT AccountID, CustomerID, Balance 
        FROM Accounts 
        FOR UPDATE;
        
    v_MaintenanceFee CONSTANT NUMBER := 50.00; 
    v_NewBalance NUMBER;
    v_Count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('
    
    FOR r_acc IN ApplyAnnualFee LOOP
        v_NewBalance := r_acc.Balance - v_MaintenanceFee;

        UPDATE Accounts
        SET Balance = v_NewBalance,
            LastModified = SYSDATE
        WHERE CURRENT OF ApplyAnnualFee;

        UPDATE Customers
        SET Balance = Balance - v_MaintenanceFee,
            LastModified = SYSDATE
        WHERE CustomerID = r_acc.CustomerID;
        
        v_Count := v_Count + 1;
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || r_acc.AccountID || 
                             ' | Old Balance: $' || TO_CHAR(r_acc.Balance, '999,999.99') || 
                             ' | New Balance: $' || TO_CHAR(v_NewBalance, '999,999.99'));
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Annual fee processing complete. Total accounts charged: ' || v_Count);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error during annual fee application: ' || SQLERRM);
END;
/
