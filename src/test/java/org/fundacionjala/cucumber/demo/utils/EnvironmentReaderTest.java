package org.fundacionjala.cucumber.demo.utils;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertNotNull;
import org.testng.annotations.Test;

public class EnvironmentReaderTest {

    @Test
    public void testFilterTags() {
        //given
        String expectedBaseUri = "demo";
        //when
        String actualBaseUri = EnvironmentReader.getInstance().getFilterTags();
        //then
        assertEquals(actualBaseUri, expectedBaseUri);
    }

    @Test
    public void testGetBaseUri() {
        //given
        String expectedBaseUri = "https://actualUri.org";
        //when
        String actualBaseUri = EnvironmentReader.getInstance().getBaseUri();
        //then
        assertEquals(actualBaseUri, expectedBaseUri);
    }

    @Test
    public void testGetJavaHome() {
        //when
        String actualBaseUri = EnvironmentReader.getInstance().getJavaHome();
        //then
        assertNotNull(actualBaseUri);
    }

    @Test
    public void testGetCommandLineVar() {
        //given
        String expectedCommandLineVar = "newvalue";
        //when
        String actualCommandLineVar = EnvironmentReader.getInstance().getCommandLineVar();
        //then
        assertEquals(actualCommandLineVar, expectedCommandLineVar);
    }
}
