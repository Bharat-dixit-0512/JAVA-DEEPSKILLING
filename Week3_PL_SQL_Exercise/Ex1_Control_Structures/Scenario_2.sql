SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance, IsVIP FROM Customers;
BEGIN
    FOR r_cust IN c_customers LOOP
        IF r_cust.Balance > 10000 THEN
            
            IF r_cust.IsVIP = 'FALSE' OR r_cust.IsVIP IS NULL THEN
                UPDATE Customers
                SET IsVIP = 'TRUE',
                    LastModified = SYSDATE
                WHERE CustomerID = r_cust.CustomerID;
                
                DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' (Balance: $' || r_cust.Balance || ') has been promoted to VIP.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' is already a VIP.');
            END IF;
        END IF;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred during VIP promotion: ' || SQLERRM);
END;
/
