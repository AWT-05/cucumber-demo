package org.fundacionjala.cucumber.demo.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * Reads environment properties.
 */
public final class Environment {

    private static final String ENVIRONMENT_NAME = "environment";
    private static final String FILTER_TAGS = "filterTags";
    private static final String PROPERTIES_FILE_PATH = "gradle.properties";
    private static final Logger LOGGER = LoggerFactory.getLogger(Environment.class);
    private static Environment instance;

    private final Properties properties;

    /**
     * Initializes instance of PropertiesUtils class.
     */
    private Environment() {
        try (FileInputStream fileInputStream = new FileInputStream(PROPERTIES_FILE_PATH)) {
            properties = new Properties();
            properties.load(fileInputStream);
        } catch (IOException e) {
            String message = "Environment not found.";
            LOGGER.error(message);
            LOGGER.info(message, e);
            throw new RuntimeException(message, e);
        }
    }

    /**
     * Gets singleton instance of the EnvironmentReader class.
     *
     * @return EnvironmentReader instance.
     */
    public static Environment getInstance() {
        if (instance == null) {
            instance = new Environment();
        }
        return instance;
    }

    /**
     * Gets string containing a specific environment property.
     *
     * @param env is the property name string.
     * @return the wanted property value.
     */
    private String getEnvProperty(final String env) {
        String property = System.getProperty(env);
        if (property == null) {
            return properties.getProperty(env);
        }
        return property;
    }

    /**
     * Gets environment name property.
     *
     * @return environment name.
     */
    public String getEnvironmentName() {
        return getEnvProperty(ENVIRONMENT_NAME);
    }

    /**
     * Gets filter tags property.
     *
     * @return filter tags property.
     */
    public String getFilterTags() {
        return getEnvProperty(FILTER_TAGS);
    }
}
