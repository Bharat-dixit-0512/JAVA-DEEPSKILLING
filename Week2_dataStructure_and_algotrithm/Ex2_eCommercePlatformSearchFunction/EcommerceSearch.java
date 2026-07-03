package Week2_dataStructure_and_algotrithm.Ex2_eCommercePlatformSearchFunction;

import java.util.Arrays;
import java.util.Comparator;

public class EcommerceSearch {
    public static Product linearSearch(Product[] products,String targetName) {
        for(Product product : products) {
            if(product.productName.equalsIgnoreCase(targetName)) {
                return product;
            }
        }
        return null;
    }
    public static Product binarySearch(Product[] products,String targetName) {
        int left = 0;
        int right = products.length - 1;
        while(left <= right) {
            int mid = (left + right) / 2;
            int compare =
                products[mid].productName.compareToIgnoreCase(targetName);
            if(compare == 0) {
                return products[mid];
            }
            else if(compare < 0) {
                left = mid + 1;
            }
            else {
                right = mid - 1;
            }
        }
        return null;
    }
    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Mobile", "Electronics"),
            new Product(103, "Watch", "Accessories"),
            new Product(104, "Camera", "Electronics"),
            new Product(105, "Shoes", "Fashion")
        };
        Product result1 =linearSearch(products, "Camera");
        System.out.println("Linear Search Result:");
        System.out.println(result1);
        Arrays.sort(products,Comparator.comparing(p -> p.productName.toLowerCase()));
        Product result2 =binarySearch(products, "Camera");
        System.out.println("\nBinary Search Result:");
        System.out.println(result2);
    }
}