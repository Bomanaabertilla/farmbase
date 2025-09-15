import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/crop.dart';

class StorageService {
  static const _key = 'crops_v1';

  Future<List<Crop>> loadCrops() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
    return list.map((e) => Crop.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveCrops(List<Crop> crops) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(crops.map((c) => c.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  /// Seed with mock crops if none exist
  Future<void> ensureInitialData(List<Crop> initial) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_key)) {
      final jsonString = jsonEncode(initial.map((c) => c.toJson()).toList());
      await prefs.setString(_key, jsonString);
    }
  }
}
