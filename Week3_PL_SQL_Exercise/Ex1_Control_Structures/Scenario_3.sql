SET SERVEROUTPUT ON;

DECLARE
    
    CURSOR c_due_loans IS
        SELECT l.LoanID, c.Name, l.LoanAmount, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
        
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('
    FOR r_loan IN c_due_loans LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || r_loan.Name || ', your loan (ID: ' || r_loan.LoanID || 
                             ') for the amount of $' || TO_CHAR(r_loan.LoanAmount, '999,999.99') || 
                             ' is due on ' || TO_CHAR(r_loan.EndDate, 'YYYY-MM-DD') || 
                             '. Please arrange for the repayment.');
    END LOOP;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    END IF;
END;
/
