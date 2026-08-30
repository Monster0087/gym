package com.gym.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class EnvUtil {
    private static final Map<String, String> envCache = new HashMap<>();

    static {
        // Try loading from .env file in the workspace root
        File envFile = new File("D:\\Project\\gym\\.env");
        if (!envFile.exists()) {
            envFile = new File("d:\\gym\\.env");
        }
        if (!envFile.exists()) {
            envFile = new File(".env");
        }
        if (envFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(envFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    line = line.trim();
                    if (line.isEmpty() || line.startsWith("#")) {
                        continue;
                    }
                    int eqIdx = line.indexOf('=');
                    if (eqIdx > 0) {
                        String key = line.substring(0, eqIdx).trim();
                        String value = line.substring(eqIdx + 1).trim();
                        // Strip quotes if present
                        if (value.startsWith("\"") && value.endsWith("\"")) {
                            value = value.substring(1, value.length() - 1);
                        } else if (value.startsWith("'") && value.endsWith("'")) {
                            value = value.substring(1, value.length() - 1);
                        }
                        envCache.put(key, value);
                    }
                }
            } catch (IOException e) {
                System.err.println("Error reading .env file: " + e.getMessage());
            }
        }
    }

    public static String get(String key) {
        // Check local cache from .env
        if (envCache.containsKey(key)) {
            return envCache.get(key);
        }
        // Fallback to System Property
        String propValue = System.getProperty(key);
        if (propValue != null) {
            return propValue;
        }
        // Fallback to System Environment Variable
        return System.getenv(key);
    }
}
