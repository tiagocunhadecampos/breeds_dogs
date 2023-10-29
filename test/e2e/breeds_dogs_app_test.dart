import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_test/flutter_test.dart' as test;

void main() {
  // Create a FlutterDriver instance, marked as potentially nullable with '?'
  driver.FlutterDriver? flutterDriver;

  // Set up the FlutterDriver connection before running tests
  test.setUpAll(() async {
    flutterDriver = await driver.FlutterDriver.connect();
  });

  // Close the FlutterDriver connection after all tests have been executed
  test.tearDownAll(() async {
    if (flutterDriver != null) {
      flutterDriver!.close();
    }
  });

  // Define a test case to tap the random button and wait for the result
  test.test('Tap the random button', () async {
    // Find the random button using the driver prefix
    final randomButton = driver.find.byValueKey('random_button');

    // Perform a tap on the random button
    await flutterDriver!.tap(randomButton);

    // Wait for the 'Selected a random breed' text using the driver prefix
    await flutterDriver!.waitFor(driver.find.text('Selected a random breed'));
  });
}
