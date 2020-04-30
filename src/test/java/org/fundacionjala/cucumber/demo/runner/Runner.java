package org.fundacionjala.cucumber.demo.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;

/**
 * Cucumber TestNG runner class.
 */
@CucumberOptions(
        strict = true,
        plugin = {"pretty"},
        glue = {"org.fundacionjala.cucumber.demo"},
        features = {"src/test/resources/features"}
)
public class Runner extends AbstractTestNGCucumberTests {

    /**
     * Executes code before all scenarios.
     */
    @BeforeTest
    public void beforeAllScenarios() {
        // Code executed before features execution.
    }

    /**
     * Executes code after all scenarios.
     */
    @AfterTest
    public void afterAllScenarios() {
        // Code executed after features execution.
    }
}
