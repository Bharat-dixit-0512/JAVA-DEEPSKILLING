package Week1_DesignPatterns.Ex11_DependencyInjectionExample;

public class DependencyInjectionTest {
    public static void main(String[] args) {
        CustomerRepository repository = new CustomerRepositoryImpl();

        CustomerService service = new CustomerService(repository);

        String customer1 = service.getCustomerDetails("1");
        String customer2 = service.getCustomerDetails("2");
        String customer3 = service.getCustomerDetails("3");

        System.out.println("Customer 1 Details: " + customer1);
        System.out.println("Customer 2 Details: " + customer2);
        System.out.println("Customer 3 Details: " + customer3);
    }
}
