package Week1_DesignPatterns.Ex8_StrategyPatternExample;

public class CreditCardPayment implements PaymentStrategy {
    private String cardHolderName;
    private String cardNumber;
    private String cvv;
    private String expiryDate;

    public CreditCardPayment(String cardHolderName, String cardNumber, String cvv, String expiryDate) {
        this.cardHolderName = cardHolderName;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.expiryDate = expiryDate;
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paid $" + amount + " using Credit Card (" + cardNumber + ").");
    }
}
