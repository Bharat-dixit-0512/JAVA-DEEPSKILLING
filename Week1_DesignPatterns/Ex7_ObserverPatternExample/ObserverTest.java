package Week1_DesignPatterns.Ex7_ObserverPatternExample;

public class ObserverTest {
    public static void main(String[] args) {
        StockMarket googleStock = new StockMarket("GOOGL", 175.50);

        Observer mobileApp = new MobileApp("Google Stocks Mobile");
        Observer webApp = new WebApp("Google Stocks Web");

        googleStock.registerObserver(mobileApp);
        googleStock.registerObserver(webApp);

        System.out.println("Updating stock price to $180.00:");
        googleStock.setPrice(180.00);

        System.out.println("\nDeregistering WebApp observer and updating stock price to $182.50:");
        googleStock.deregisterObserver(webApp);
        googleStock.setPrice(182.50);
    }
}
