package Week1_DesignPatterns.Ex3_BuilderPatternExample;

public class BuilderTest {
    public static void main(String[] args) {
        Computer basicComputer = new Computer.Builder("Intel i3", "8GB")
                .setStorage("256GB SSD")
                .build();

        Computer gamingComputer = new Computer.Builder("Intel i9", "32GB")
                .setStorage("2TB NVMe SSD")
                .setGraphicsCardEnabled(true)
                .setBluetoothEnabled(true)
                .build();

        System.out.println("Basic Computer: " + basicComputer);
        System.out.println("Gaming Computer: " + gamingComputer);
    }
}
