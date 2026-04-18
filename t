package com.zenauto.core.utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.*;

public class CsvReader {

    public static List<Map<String, String>> getActiveDevices(String filePath) {
        List<Map<String, String>> devices = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {

            String headerLine = br.readLine();
            String[] headers = headerLine.split(",");

            String line;

            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");

                Map<String, String> row = new HashMap<>();
                for (int i = 0; i < headers.length; i++) {
                    row.put(headers[i].trim(), values[i].trim());
                }

                if ("yes".equalsIgnoreCase(row.get("run"))) {
                    devices.add(row);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("Error reading CSV: " + e.getMessage());
        }

        return devices;
    }
}

@DataProvider(name = "devices", parallel = true)
public Object[][] getDevices() {

    List<Map<String, String>> devices =
        CsvConfigReader.getAllRunEnabledDevices();

    Object[][] data = new Object[devices.size()][1];

    for (int i = 0; i < devices.size(); i++) {
        data[i][0] = devices.get(i);
    }

    return data;
}

