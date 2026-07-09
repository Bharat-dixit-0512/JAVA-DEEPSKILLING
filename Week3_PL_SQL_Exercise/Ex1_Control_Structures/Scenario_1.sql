SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR c_customers IS
        SELECT CustomerID, Name, DOB FROM Customers;
    
    v_age NUMBER;
BEGIN
    FOR r_cust IN c_customers LOOP
        
        IF r_cust.DOB IS NOT NULL THEN
            v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, r_cust.DOB) / 12);

            IF v_age > 60 THEN
                
                UPDATE Loans
                SET InterestRate = InterestRate - 1
                WHERE CustomerID = r_cust.CustomerID;

                IF SQL%ROWCOUNT > 0 THEN
                    DBMS_OUTPUT.PUT_LINE('Interest rate discount applied for Customer: ' || r_cust.Name || ' (Age: ' || v_age || ').');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Customer: ' || r_cust.Name || ' (Age: ' || v_age || ') is over 60 but has no loans.');
                END IF;
            END IF;
        END IF;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
