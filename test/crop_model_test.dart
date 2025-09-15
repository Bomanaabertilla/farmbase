import 'package:flutter_test/flutter_test.dart';
import 'package:crop_app/models/crop.dart';

void main() {
  group('Crop Model Validation', () {
    test('Planting date should be before harvest date', () {
      final planting = DateTime(2025, 1, 1);
      final harvest = DateTime(2025, 2, 1);

      final crop = Crop(
        id: 'test',
        name: 'Test Crop',
        plantingDate: planting,
        expectedHarvestDate: harvest,
        notes: '',
      );

      expect(crop.plantingDate.isBefore(crop.expectedHarvestDate), true);
    });

    test('Invalid crop: harvest before planting', () {
      final planting = DateTime(2025, 3, 1);
      final harvest = DateTime(2025, 2, 1);

      final crop = Crop(
        id: 'invalid',
        name: 'Invalid Crop',
        plantingDate: planting,
        expectedHarvestDate: harvest,
        notes: '',
      );

      expect(crop.plantingDate.isBefore(crop.expectedHarvestDate), false);
    });
  });
}
