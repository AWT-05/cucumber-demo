package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.After;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Before;
import io.cucumber.java.BeforeStep;
import io.cucumber.java.Scenario;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

public class Hooks {
    @Before(value = "@Books")
    public void printMessage2Scenario(Scenario scenario) {
        System.out.println("Name: " + scenario.getName());
        System.out.println("Line: " + scenario.getLine());
    }

    @Before("@Books")
    public void printMessage3Scenario(Scenario scenario) {
        System.out.println("Name: " + scenario.getName());
        System.out.println("Line: " + scenario.getLine());
    }

    @After("@Books")
    public void printEndMessage2(Scenario scenario) {
        System.out.println("Scenario tags:   " + scenario.getSourceTagNames().toString());
    }

    @BeforeStep()
    public void printStartMessage() {
        System.out.println("Before: ===========");
    }

    @AfterStep()
    public void printEndtMessage() {
        System.out.println("After: ************");
    }

    @Before(value = "@Example")
    public void StartOpenBrowser() {
        if (Desktop.isDesktopSupported() && Desktop.getDesktop().isSupported(Desktop.Action.BROWSE)) {
            try {
                Desktop.getDesktop().browse(new URI("https://my-json-server.typicode.com/typicode/demo"));
            } catch (URISyntaxException | IOException e) {
                e.printStackTrace();
            }
        }
    }

    @After("@Example")
    public void printScenarioDetails(Scenario scenario) {
        System.out.println("Scenario name:   " + scenario.getName());
        System.out.println("Scenario ID:     " + scenario.getId());
        System.out.println("Scenario Line:   " + scenario.getLine());
        System.out.println("Scenario Status: " + scenario.getStatus());
        System.out.println("Scenario URI:    " + scenario.getUri());
        System.out.println("Scenario isFailed: " + scenario.isFailed());
        System.out.println("Scenario tags:   " + scenario.getSourceTagNames().toString());
    }
}
