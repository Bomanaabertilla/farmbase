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
        id: 'tomato',
        name: 'Tomato',
        plantingDate: DateTime.now().subtract(const Duration(days: 30)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 30)),
        notes: 'Cherry tomatoes near the greenhouse.',
      ),
      Crop(
        id: 'maize',
        name: 'Maize',
        plantingDate: DateTime.now().subtract(const Duration(days: 60)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 10)),
        notes: 'Planted in rows A & B.',
      ),
      Crop(
        id: 'lettuce',
        name: 'Lettuce',
        plantingDate: DateTime.now().subtract(const Duration(days: 10)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 20)),
        notes: 'Grow under partial shade.',
      ),
      Crop(
        id: 'cassava',
        name: 'Cassava',
        plantingDate: DateTime.now().subtract(const Duration(days: 200)),
        expectedHarvestDate: DateTime.now().add(const Duration(days: 100)),
        notes: 'Long growth cycle.',
      ),
      Crop(
        id: 'beans',
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

  Future<void> addCrop(Crop crop) async {
    _crops.add(crop);
    await _storage.saveCrops(_crops);
    notifyListeners();
  }

  Future<void> updateCrop(Crop updated) async {
    final idx = _crops.indexWhere((c) => c.id == updated.id);
    if (idx != -1) {
      _crops[idx] = updated;
      await _storage.saveCrops(_crops);
      notifyListeners();
    }
  }

  Future<void> deleteCrop(String id) async {
    _crops.removeWhere((c) => c.id == id);
    await _storage.saveCrops(_crops);
    notifyListeners();
  }

  Future<void> updateStatus(String id, CropStatus newStatus) async {
    final idx = _crops.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _crops[idx].status = newStatus;
      await _storage.saveCrops(_crops);
      notifyListeners();
    }
  }

  List<Crop> search(String query) {
    if (query.trim().isEmpty) return crops;
    final lower = query.toLowerCase();
    return _crops.where((c) => c.name.toLowerCase().contains(lower)).toList();
  }
}
