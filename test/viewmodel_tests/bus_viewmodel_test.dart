import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_viewmodel.dart';

void main() {
  group('BusViewModelTest', () {
    group('currentIndex', () {
      test('When constructed it is 0', () {
        var model = BusViewModel();
        expect(model.currentIndex, 0);
      });
      test('When a different item is tapped the index changes', () {
        var model = BusViewModel();
        var tappedIndex = 1;
        model.onItemTapped(tappedIndex);
        expect(model.currentIndex, tappedIndex);
      });
    });
  });
}
