import 'package:flutter/foundation.dart';

enum CropStatus { growing, ready, harvested }

String cropStatusToString(CropStatus s) {
  switch (s) {
    case CropStatus.growing:
      return "Growing";
    case CropStatus.ready:
      return "Ready";
    case CropStatus.harvested:
      return "Harvested";
  }
}

CropStatus cropStatusFromString(String s) {
  switch (s.toLowerCase()) {
    case 'ready':
      return CropStatus.ready;
    case 'harvested':
      return CropStatus.harvested;
    default:
      return CropStatus.growing;
  }
}

class Crop {
  final String id;
  String name;
  DateTime plantingDate;
  DateTime expectedHarvestDate;
  String notes;
  CropStatus status;

  Crop({
    required this.id,
    required this.name,
    required this.plantingDate,
    required this.expectedHarvestDate,
    this.notes = '',
    this.status = CropStatus.growing,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'] as String,
      name: json['name'] as String,
      plantingDate: DateTime.parse(json['plantingDate'] as String),
      expectedHarvestDate: DateTime.parse(json['expectedHarvestDate'] as String),
      notes: json['notes'] as String? ?? '',
      status: cropStatusFromString(json['status'] as String? ?? 'growing'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'plantingDate': plantingDate.toIso8601String(),
        'expectedHarvestDate': expectedHarvestDate.toIso8601String(),
        'notes': notes,
        'status': cropStatusToString(status),
      };
}
