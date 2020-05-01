package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.fundacionjala.cucumber.demo.books.Book;
import org.fundacionjala.cucumber.demo.books.BookStore;

import java.util.ArrayList;
import java.util.List;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertNotNull;
import static org.testng.Assert.assertNull;

public class BookStoreSteps {

    private BookStore store;
    private List<Book> foundBooks;
    private Book foundBook;

    @Before("@Books")
    public void setUp() {
        store = new BookStore();
        foundBooks = new ArrayList<>();
        System.out.println("Before: All steps in a Scenario");
    }

    @Given("I have the following books in the store")
    public void haveBooksInTheStore(DataTable table) {
        List<List<String>> rows = table.asLists(String.class);

        for (List<String> columns: rows) {
            store.addBook(new Book(columns.get(0), columns.get(1)));
        }
    }

    @When("I search for books by author {string}")
    public void searchForBooksByAuthor(String author) {
        foundBooks = store.booksByAuthor(author);
    }

    @When("I search for a book titled {string}")
    public void searchForBookByTitled(String title) {
        foundBook = store.bookByTitle(title).orElse(null);
    }

    @Then("I find {int} books")
    public void iFindBooks(int numberBooks) {
        assertEquals(foundBooks.size(), numberBooks);
    }

    @Then("I find a book")
    public void iFindABook() {
        assertNotNull(foundBook);
    }

    @Then("I find no book")
    public void iFindNoBook() {
        assertNull(foundBook);
    }

    @After("@Books")
    public void endFeature() {
        System.out.println("After: end Scenario");
    }
}
