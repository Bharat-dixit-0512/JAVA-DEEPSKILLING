package Week1_DesignPatterns.Ex8_StrategyPatternExample;

public class StrategyTest {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        PaymentStrategy creditCard = new CreditCardPayment("John Doe", "1234-5678-9876-5432", "123", "12/28");
        context.setPaymentStrategy(creditCard);
        context.executePayment(250.0);

        PaymentStrategy payPal = new PayPalPayment("john.doe@example.com", "securepass");
        context.setPaymentStrategy(payPal);
        context.executePayment(120.50);
    }
}
