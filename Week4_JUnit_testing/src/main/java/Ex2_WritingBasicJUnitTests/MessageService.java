package Ex2_WritingBasicJUnitTests;

public class MessageService {
    public String formatMessage(String name) {
        return "Hello, " + name + "!";
    }

    public int countWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        return text.trim().split("\\s+").length;
    }
}
