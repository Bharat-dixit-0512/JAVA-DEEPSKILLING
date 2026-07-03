package Week1_DesignPatterns.Ex11_DependencyInjectionExample;

public class CustomerService {
    private CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public String getCustomerDetails(String id) {
        return customerRepository.findCustomerById(id);
    }
}
