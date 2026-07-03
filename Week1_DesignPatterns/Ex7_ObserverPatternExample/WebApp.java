package Week1_DesignPatterns.Ex7_ObserverPatternExample;

public class WebApp implements Observer {
    private String name;

    public WebApp(String name) {
        this.name = name;
    }

    @Override
    public void update(String stockName, double price) {
        System.out.println("Web App [" + name + "] Notification: Stock " + stockName + " price updated to $" + price);
    }
}
