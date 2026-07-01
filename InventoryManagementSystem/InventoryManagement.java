package InventoryManagementSystem;

import java.util.HashMap;

public class InventoryManagement {

    HashMap<Integer, Product> inventory = new HashMap<>();

    // Add Product
    public void addProduct(Product product) {
        inventory.put(product.productId, product);
        System.out.println("Product Added Successfully.");
    }

    // Update Product
    public void updateProduct(int id, int quantity, double price) {

        if (inventory.containsKey(id)) {

            Product p = inventory.get(id);

            p.quantity = quantity;
            p.price = price;

            System.out.println("Product Updated Successfully.");
        } else {
            System.out.println("Product Not Found.");
        }
    }

    // Delete Product
    public void deleteProduct(int id) {

        if (inventory.remove(id) != null) {
            System.out.println("Product Deleted Successfully.");
        } else {
            System.out.println("Product Not Found.");
        }
    }

    // Display Inventory
    public void displayProducts() {

        System.out.println("\nInventory:");

        for (Product product : inventory.values()) {
            System.out.println(product);
        }
    }

    // Main Method
    public static void main(String[] args) {

        InventoryManagement inventory = new InventoryManagement();

        inventory.addProduct(new Product(101, "Laptop", 10, 55000));

        inventory.addProduct(new Product(102, "Mouse", 50, 700));

        inventory.addProduct(new Product(103, "Keyboard", 25, 1200));

        inventory.displayProducts();

        inventory.updateProduct(102, 60, 750);

        inventory.displayProducts();

        inventory.deleteProduct(101);

        inventory.displayProducts();
    }
}