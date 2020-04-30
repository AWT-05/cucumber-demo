package org.fundacionjala.cucumber.demo.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertNotNull;
import org.testng.annotations.Test;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class PropertyObtainer {

    private static final String BASE_URI = "baseUri";
    private static final String FILTER_TAGS = "filterTags";
    private static final String JAVA_HOME = "llave";
    private static final Logger LOGGER = LoggerFactory.getLogger(PropertiesUtils.class);

    private static PropertyObtainer instance = new PropertyObtainer();
    private Properties envProperties;

    /**
     * Constructor for PropertiesUtils class.
     */
    private PropertyObtainer() {
        try (FileInputStream fileInputStream = new FileInputStream("gradle.properties")) {
            envProperties = new Properties();
            envProperties.load(fileInputStream);
        } catch (IOException e) {
            String message = "Environment not found.";
            LOGGER.error(message);
            LOGGER.info(message, e);
            throw new RuntimeException(message, e);
        }
    }

    /**
     * Returns the instance of the PropertiesUtils class.
     *
     * @return the instance.
     */
    public static PropertyObtainer getInstance() {
        return instance;
    }

    /**
     * Returns a String containing an specific environment property.
     *
     * @param env is the property name string.
     * @return the wanted property value.
     */
    private String getEnvProperty(final String env) {
        String property = System.getProperty(env);
        if (property == null) {
            return envProperties.getProperty(env);
        }
        return property;
    }

    public String getBaseUri() {
        return getEnvProperty(BASE_URI);
    }

    public String getFilterTags() {
        return getEnvProperty(FILTER_TAGS);
    }

    public String getJavaHome() {
        return getEnvProperty(JAVA_HOME);
    }

    //    @Test
//    public void testGetInstance() {
//
//    }

    @Test
    public void testFilterTags() {
        //given
        String expectedBaseUri = "demo";
        //when
        String actualBaseUri = getInstance().getFilterTags();
        //then
        assertEquals(actualBaseUri, expectedBaseUri);
    }

    @Test
    public void testGetBaseUri() {
        //given
        String expectedBaseUri = "https://actualUri.org";
        //when
        String actualBaseUri = getInstance().getBaseUri();
        //then
        assertEquals(actualBaseUri, expectedBaseUri);
    }

    @Test
    public void testGetJavaHome() {
        //when
        String actualBaseUri = getInstance().getJavaHome();
        //then
        assertNotNull(actualBaseUri);
    }

}
