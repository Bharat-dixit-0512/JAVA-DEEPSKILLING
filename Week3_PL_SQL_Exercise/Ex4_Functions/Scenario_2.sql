SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_LoanAmount IN NUMBER,
    p_InterestRate IN NUMBER, 
    p_DurationYears IN NUMBER  
) RETURN NUMBER IS
    v_MonthlyInstallment NUMBER;
    v_MonthlyRate NUMBER;      
    v_TotalMonths NUMBER;      
BEGIN
    
    IF p_LoanAmount IS NULL OR p_LoanAmount <= 0 THEN
        RETURN 0;
    END IF;
    
    IF p_DurationYears IS NULL OR p_DurationYears <= 0 THEN
        RETURN 0;
    END IF;
    
    v_TotalMonths := p_DurationYears * 12;

    IF p_InterestRate IS NULL OR p_InterestRate = 0 THEN
        v_MonthlyInstallment := p_LoanAmount / v_TotalMonths;
    ELSE
        
        v_MonthlyRate := p_InterestRate / 12 / 100;

        v_MonthlyInstallment := p_LoanAmount * v_MonthlyRate * POWER(1 + v_MonthlyRate, v_TotalMonths) / 
                               (POWER(1 + v_MonthlyRate, v_TotalMonths) - 1);
    END IF;
    
    RETURN ROUND(v_MonthlyInstallment, 2);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in CalculateMonthlyInstallment: ' || SQLERRM);
        RETURN -1;
END;
/
