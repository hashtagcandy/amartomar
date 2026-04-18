package com.unifiedmobile.runners;

import com.unifiedmobile.core.utils.CsvConfigReader;
import com.unifiedmobile.core.utils.DeviceContext;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import io.cucumber.testng.PickleWrapper;
import io.cucumber.testng.FeatureWrapper;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import java.util.List;
import java.util.Map;

@CucumberOptions(
        features = "src/test/resources/features",
        glue = {"com.unifiedmobile.steps", "com.unifiedmobile.hooks"},
        plugin = {
                "pretty",
                "html:target/cucumber-reports/cucumber-report.html",
                "json:target/cucumber-reports/cucumber-report.json",
                "timeline:target/cucumber-reports/timeline",
                "io.qameta.allure.cucumber7jvm.AllureCucumber7Jvm"
        }
)
public class TestRunner extends AbstractTestNGCucumberTests {

    // 🔥 THIS IS THE KEY CHANGE
    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {

        List<Map<String, String>> devices =
                CsvConfigReader.getAllRunEnabledDevices();

        Object[][] scenarios = super.scenarios();

        Object[][] result =
                new Object[scenarios.length * devices.size()][3];

        int index = 0;

        for (Map<String, String> device : devices) {
            for (Object[] scenario : scenarios) {

                result[index][0] = scenario[0]; // pickle
                result[index][1] = scenario[1]; // feature
                result[index][2] = device;      // device config

                index++;
            }
        }

        return result;
    }

    // 🔥 THIS CONNECTS DEVICE WITH THREAD
    @Test(dataProvider = "scenarios")
    public void runScenario(PickleWrapper pickle,
                            FeatureWrapper feature,
                            Map<String, String> device) {

        // ✅ SET DEVICE HERE
        DeviceContext.setCurrentDeviceConfig(device);

        // Run actual cucumber scenario
        super.runScenario(pickle, feature);
    }
}
