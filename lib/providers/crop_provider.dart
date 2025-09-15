import 'package:flutter/foundation.dart';
import '../models/crop.dart';
import '../services/storage_service.dart';

class CropProvider extends ChangeNotifier {
  final StorageService _storage;
  List<Crop> _crops = [];

  List<Crop> get crops => List.unmodifiable(_crops);

  CropProvider(this._storage);

  Future<void> loadInitialData() async {
    final initialMock = [
      Crop(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_tomato',
        name: 'Tomato',
        plantingDate: DateTime.now().subtract(const Duration(days: 30)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 30)),
        notes: 'Cherry tomatoes near the greenhouse.',
      ),
      Crop(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_maize',
        name: 'Maize',
        plantingDate: DateTime.now().subtract(const Duration(days: 60)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 10)),
        notes: 'Planted in rows A & B.',
      ),
      Crop(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_lettuce',
        name: 'Lettuce',
        plantingDate: DateTime.now().subtract(const Duration(days: 10)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 20)),
        notes: 'Grow under partial shade.',
      ),
      Crop(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_cassava',
        name: 'Cassava',
        plantingDate: DateTime.now().subtract(const Duration(days: 200)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 100)),
        notes: 'Long growth cycle.',
      ),
      Crop(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_beans',
        name: 'Beans',
        plantingDate: DateTime.now().subtract(const Duration(days: 5)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 40)),
        notes: 'Intercropped with maize.',
      ),
    ];

    await _storage.ensureInitialData(initialMock);
    _crops = await _storage.loadCrops();
    notifyListeners();
  }

  List<Crop> search(String query) {
    if (query.trim().isEmpty) return crops;
    final lower = query.toLowerCase();
    return _crops.where((c) => c.name.toLowerCase().contains(lower)).toList();
  }
}
