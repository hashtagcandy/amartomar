import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomReportGenerator {

    public static void generateReport(Set<String> featureNames) {
        // List your cucumber JSON output files here
        File jsonFile = new File("target/cucumber-parallel/1.json"); // Adjust if you have more
        List<String> jsonFiles = new ArrayList<>();
        jsonFiles.add(jsonFile.getAbsolutePath());

        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        File reportOutputDirectory = new File("target/site/cucumber-reports/CombinedReport_" + timestamp);

        Configuration config = new Configuration(reportOutputDirectory, "BDD Automation");
        config.setBuildNumber("1");

        for (String feature : featureNames) {
            config.addClassifications("Feature", feature);
        }

        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, config);
        reportBuilder.generateReports();
    }
}