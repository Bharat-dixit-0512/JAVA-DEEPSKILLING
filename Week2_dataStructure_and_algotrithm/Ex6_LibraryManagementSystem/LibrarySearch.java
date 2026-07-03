package Week2_dataStructure_and_algotrithm.Ex6_LibraryManagementSystem;
import java.util.Arrays;
import java.util.Comparator;

public class LibrarySearch {

    // Linear Search
    public static Book linearSearch(Book[] books, String title) {

        for (Book book : books) {

            if (book.title.equalsIgnoreCase(title)) {
                return book;
            }
        }

        return null;
    }

    // Binary Search
    public static Book binarySearch(Book[] books, String title) {

        int left = 0;
        int right = books.length - 1;

        while (left <= right) {

            int mid = (left + right) / 2;

            int compare = books[mid].title.compareToIgnoreCase(title);

            if (compare == 0) {
                return books[mid];
            }

            else if (compare < 0) {
                left = mid + 1;
            }

            else {
                right = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {

        Book[] books = {

                new Book(101, "Java", "James Gosling"),
                new Book(102, "Python", "Guido van Rossum"),
                new Book(103, "C++", "Bjarne Stroustrup"),
                new Book(104, "DBMS", "Korth"),
                new Book(105, "Operating System", "Galvin")

        };

        // Linear Search
        Book result1 = linearSearch(books, "DBMS");

        System.out.println("Linear Search Result:");

        if (result1 != null)
            System.out.println(result1);
        else
            System.out.println("Book Not Found.");

        // Sort before Binary Search
        Arrays.sort(books, Comparator.comparing(b -> b.title));

        // Binary Search
        Book result2 = binarySearch(books, "DBMS");

        System.out.println("\nBinary Search Result:");

        if (result2 != null)
            System.out.println(result2);
        else
            System.out.println("Book Not Found.");
    }
}
