public static void generateReport(Set<String> featureNames) {
    List<String> jsonFiles = new ArrayList<>();
    jsonFiles.add("target/cucumber-parallel/output.json");

    String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

    // Combine feature names with "_" (limit to avoid long folder names)
    String joinedFeatures = String.join("_", featureNames);
    if (joinedFeatures.length() > 50) {  // Prevent folder name from being too long
        joinedFeatures = joinedFeatures.substring(0, 50).replaceAll("[^a-zA-Z0-9_]", "");
    }

    File reportOutputDirectory = new File("target/site/cucumber-reports/" + joinedFeatures + "_" + timestamp);

    Configuration config = new Configuration(reportOutputDirectory, "BDD Automation");
    config.setBuildNumber("1");

    for (String feature : featureNames) {
        config.addClassifications("Feature", feature);
    }

    ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, config);
    reportBuilder.generateReports();
}