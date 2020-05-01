package org.fundacionjala.cucumber.demo.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        strict = true,
        plugin = {"pretty"},
        glue = {"org.fundacionjala.cucumber.demo"},
        features = {"src/test/resources/features/bookStore.feature"}
)
public class BookStoreRunner extends AbstractTestNGCucumberTests {
}
