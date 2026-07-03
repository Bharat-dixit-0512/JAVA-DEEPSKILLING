package Week1_DesignPatterns.Ex6_ProxyPatternExample;

public class ProxyTest {
    public static void main(String[] args) {
        Image image = new ProxyImage("test_image.jpg");

        System.out.println("Image will be displayed for the first time (should load from server):");
        image.display();

        System.out.println("\nImage will be displayed for the second time (should use cached version):");
        image.display();
    }
}
