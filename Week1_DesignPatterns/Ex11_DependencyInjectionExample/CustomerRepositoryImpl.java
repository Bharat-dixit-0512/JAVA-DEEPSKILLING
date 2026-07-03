package Week1_DesignPatterns.Ex11_DependencyInjectionExample;

public class CustomerRepositoryImpl implements CustomerRepository {
    @Override
    public String findCustomerById(String id) {
        if ("1".equals(id)) {
            return "John Doe (Enterprise Client)";
        } else if ("2".equals(id)) {
            return "Jane Smith (Retail Client)";
        }
        return "Customer not found";
    }
}
