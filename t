@Test(dataProvider = "devices", dataProviderClass = DeviceDataProvider.class)
public void runTest(Map<String, String> deviceConfig) throws Exception {

    // 🔥 MUST DO
    DeviceContext.setCurrentDeviceConfig(deviceConfig);

    DriverFactory.initMobileDriver("amazon");

    System.out.println("Running on: " + deviceConfig.get("deviceName"));
}
