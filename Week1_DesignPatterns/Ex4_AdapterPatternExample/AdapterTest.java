package Week1_DesignPatterns.Ex4_AdapterPatternExample;

public class AdapterTest {
    public static void main(String[] args) {
        PayPalGateway payPalGateway = new PayPalGateway();
        PaymentProcessor payPalProcessor = new PayPalAdapter(payPalGateway);

        StripeGateway stripeGateway = new StripeGateway();
        PaymentProcessor stripeProcessor = new StripeAdapter(stripeGateway);

        payPalProcessor.processPayment(150.0);
        stripeProcessor.processPayment(250.0);
    }
}
