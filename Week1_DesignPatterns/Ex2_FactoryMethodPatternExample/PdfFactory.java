package Week1_DesignPatterns.Ex2_FactoryMethodPatternExample;

public class PdfFactory extends DocumentFactory {

    @Override
    public Document createDocument() {
        return new PdfDocument();
    }
}