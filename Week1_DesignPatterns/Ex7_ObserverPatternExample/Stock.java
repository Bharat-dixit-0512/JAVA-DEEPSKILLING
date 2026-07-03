package Week1_DesignPatterns.Ex7_ObserverPatternExample;

public interface Stock {
    void registerObserver(Observer o);
    void deregisterObserver(Observer o);
    void notifyObservers();
}
