package org.fundacionjala.cucumber.demo.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public final class EnvironmentReader {

    private static final String BASE_URI = "baseUri";
    private static final String FILTER_TAGS = "filterTags";
    private static final String JAVA_HOME = "java.home";
    private static final String COMMAND_LINE = "new.key";
    private static final Logger LOGGER = LoggerFactory.getLogger(EnvironmentReader.class);

    private static EnvironmentReader instance = new EnvironmentReader();
    private Properties envProperties;

    /**
     * Constructor for PropertiesUtils class.
     */
    private EnvironmentReader() {
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
    public static EnvironmentReader getInstance() {
        return instance;
    }

    /**
     * Returns a String containing a specific environment property.
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

    public String getCommandLineVar() {
        return getEnvProperty(COMMAND_LINE);
    }

}
