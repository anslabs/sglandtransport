import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';

void main() {
  test('toggle dark mode sets isDarkMode', () {
    final provider = SettingsProvider();
    expect(provider.isDarkMode, false);
    provider.toggleDarkMode(true);
    expect(provider.isDarkMode, true);
  });

  test('toggle dark mode notifies listeners', () {
    int listenerCallCount = 0;
    final provider = SettingsProvider()
      ..addListener(() {
        listenerCallCount += 1;
      });
    provider.toggleDarkMode(true);
    expect(listenerCallCount, 1);
  });
}
