package Ex1_SettingUpJUnit;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CalculatorTest {

    @Test
    public void addShouldReturnSum() {
        Calculator calculator = new Calculator();
        assertEquals(8, calculator.add(3, 5));
    }

    @Test
    public void subtractShouldReturnDifference() {
        Calculator calculator = new Calculator();
        assertEquals(2, calculator.subtract(5, 3));
    }
}
