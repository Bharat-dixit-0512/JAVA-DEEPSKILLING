package Week1_DesignPatterns.Ex2_FactoryMethodPatternExample;

public class ExcelFactory extends DocumentFactory {

    @Override
    public Document createDocument() {
        return new ExcelDocument();
    }
}