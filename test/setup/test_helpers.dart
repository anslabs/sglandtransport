import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:mockito/mockito.dart';

import 'test_data.dart' as test_data;

class BusServiceMock extends Mock implements BusService {}

BusService getAndRegisterBusServiceMock({
  String busStopForBusArrival = '01019',
}) {
  _removeRegistrationIfExists<BusService>();
  var service = BusServiceMock();
  when(service.getBusArrivalServices(busStopForBusArrival)).thenAnswer(
    (realInvocation) {
      return Future.value(test_data.busArrivalServiceModelList);
    },
  );
  locator.registerSingleton<BusService>(service);
  return service;
}

FirebaseAnalyticsService getAndRegisterFirebaseAnalyticsService() {
  _removeRegistrationIfExists<FirebaseAnalyticsService>();
  var service = FirebaseAnalyticsService();
  locator.registerSingleton<FirebaseAnalyticsService>(service);
  return service;
}

void registerServices() {
  getAndRegisterFirebaseAnalyticsService();
  getAndRegisterBusServiceMock();
}

void unregisterServices() {
  locator.unregister<FirebaseAnalyticsService>();
  locator.unregister<BusService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
