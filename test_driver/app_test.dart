import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('SG Land Transport App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    group('Buses', () {
      final busStopCardFinder = find.byValueKey('busStopCard-0');
      final busArrivalCardFinder = find.byValueKey('busArrivalCard-0');
      final nearbyBottomBarFinder = find.text('Nearby');
      final favouriteBottomBarFinder = find.text('Favorites');
      final favouriteIconButtonFinder = find.byValueKey('favouriteIconButton');
      final noFavouriteBusStopsFoundFinder =
          find.byValueKey('noFavouriteBusStopsFound');
      final searchIconButtonFinder = find.byValueKey('searchIconButton');

      test('Should load the app', () async {
        await driver.waitFor(busStopCardFinder);
      });

      test('Should switch between Nearby and Favorites', () async {
        await driver.tap(favouriteBottomBarFinder);
        await driver.tap(nearbyBottomBarFinder);
        await driver.waitFor(busStopCardFinder);
      });

      test('Should show bus arrival times for a given bus stop', () async {
        await driver.waitFor(busStopCardFinder);
        await driver.tap(busStopCardFinder);
        await driver.waitFor(busArrivalCardFinder);
      });

      test('Should add a bus stop to Favorites', () async {
        await driver.tap(favouriteIconButtonFinder);
        await driver.tap(find.pageBack());
        await driver.tap(favouriteBottomBarFinder);
        await driver.waitFor(busStopCardFinder);
      });

      test('Should remove a bus stop from Favorites', () async {
        await driver.tap(busStopCardFinder);
        await driver.waitFor(busArrivalCardFinder);
        await driver.tap(favouriteIconButtonFinder);
        await driver.tap(find.pageBack());
        await driver.waitFor(noFavouriteBusStopsFoundFinder);
      });

      test('Should open Search screen', () async {
        await driver.tap(searchIconButtonFinder);
        await driver.waitFor(find.byType('TextField'));
      });

      test('Should show a search result', () async {
        await driver.tap(find.byType('TextField'));
        await driver.enterText('hotel');
        await driver.waitFor(busStopCardFinder);
      });
    });
  });
}
