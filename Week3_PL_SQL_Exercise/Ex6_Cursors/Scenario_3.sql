SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, CustomerID, LoanAmount, InterestRate 
        FROM Loans 
        FOR UPDATE;
        
    v_Reduction NUMBER;
    v_NewRate NUMBER;
    v_Count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('

    FOR r_loan IN UpdateLoanInterestRates LOOP
        
        IF r_loan.LoanAmount > 10000 THEN
            v_Reduction := 0.50;
        ELSE
            v_Reduction := 0.25;
        END IF;

        v_NewRate := r_loan.InterestRate - v_Reduction;

        UPDATE Loans
        SET InterestRate = v_NewRate
        WHERE CURRENT OF UpdateLoanInterestRates;
        
        v_Count := v_Count + 1;
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || r_loan.LoanID || 
                             ' | Amount: $' || TO_CHAR(r_loan.LoanAmount, '999,999.99') || 
                             ' | Old Interest: ' || TO_CHAR(r_loan.InterestRate, '99.99') || '%' ||
                             ' | New Interest: ' || TO_CHAR(v_NewRate, '99.99') || '%');
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Loan interest rates updated successfully. Total loans updated: ' || v_Count);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error while updating loan interest rates: ' || SQLERRM);
END;
/
