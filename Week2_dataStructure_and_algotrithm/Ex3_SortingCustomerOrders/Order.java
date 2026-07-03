package Week2_dataStructure_and_algotrithm.Ex3_SortingCustomerOrders;
public class Order {

    int orderId;
    String customerName;
    double totalPrice;

    public Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return orderId + " | " + customerName + " | ₹" + totalPrice;
    }
}