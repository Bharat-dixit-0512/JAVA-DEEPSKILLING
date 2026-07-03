package Week1_DesignPatterns.Ex8_StrategyPatternExample;

public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void executePayment(double amount) {
        if (paymentStrategy == null) {
            System.out.println("No payment strategy selected.");
        } else {
            paymentStrategy.pay(amount);
        }
    }
}
