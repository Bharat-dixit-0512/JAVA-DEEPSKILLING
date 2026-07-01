package SortingCustomerOrders;
public class OrderSorting {

    // Bubble Sort
    public static void bubbleSort(Order[] orders) {

        int n = orders.length;

        for (int i = 0; i < n - 1; i++) {

            for (int j = 0; j < n - i - 1; j++) {

                if (orders[j].totalPrice > orders[j + 1].totalPrice) {

                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    // Quick Sort
    public static void quickSort(Order[] orders, int low, int high) {

        if (low < high) {

            int pivotIndex = partition(orders, low, high);

            quickSort(orders, low, pivotIndex - 1);
            quickSort(orders, pivotIndex + 1, high);
        }
    }

    // Partition Method
    public static int partition(Order[] orders, int low, int high) {

        double pivot = orders[high].totalPrice;

        int i = low - 1;

        for (int j = low; j < high; j++) {

            if (orders[j].totalPrice < pivot) {

                i++;

                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }

        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }

    // Display Orders
    public static void display(Order[] orders) {

        for (Order order : orders) {
            System.out.println(order);
        }
    }

    public static void main(String[] args) {

        Order[] orders = {

                new Order(101, "Amit", 5500),
                new Order(102, "Rahul", 2300),
                new Order(103, "Priya", 7600),
                new Order(104, "Neha", 4100),
                new Order(105, "Rohan", 1800)

        };

        // Bubble Sort
        System.out.println("Bubble Sort:");

        bubbleSort(orders);

        display(orders);

        System.out.println();

        // New Array for Quick Sort
        Order[] orders2 = {

                new Order(101, "Amit", 5500),
                new Order(102, "Rahul", 2300),
                new Order(103, "Priya", 7600),
                new Order(104, "Neha", 4100),
                new Order(105, "Rohan", 1800)

        };

        System.out.println("Quick Sort:");

        quickSort(orders2, 0, orders2.length - 1);

        display(orders2);
    }
}