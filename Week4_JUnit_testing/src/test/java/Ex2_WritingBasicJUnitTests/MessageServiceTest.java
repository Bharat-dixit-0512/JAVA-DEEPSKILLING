package Ex2_WritingBasicJUnitTests;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class MessageServiceTest {

    @Test
    public void formatMessageShouldPrefixHello() {
        MessageService service = new MessageService();
        assertEquals("Hello, Alice!", service.formatMessage("Alice"));
    }

    @Test
    public void countWordsShouldReturnNumberOfWords() {
        MessageService service = new MessageService();
        assertEquals(3, service.countWords("JUnit testing is fun"));
    }
}
