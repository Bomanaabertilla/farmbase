import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/crop.dart';

class CropTile extends StatelessWidget {
  final Crop crop;
  final VoidCallback onTap;

  const CropTile({super.key, required this.crop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.yMMMd();
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade800,
          child: Text(crop.name.isNotEmpty ? crop.name[0].toUpperCase() : '?'),
        ),
        title: Text(crop.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Planted: ${df.format(crop.plantingDate)} • Harvest: ${df.format(crop.expectedHarvestDate)}'),
        trailing: Text(
          cropStatusToString(crop.status),
          style: TextStyle(
            color: crop.status == CropStatus.growing
                ? Colors.green
                : crop.status == CropStatus.ready
                    ? Colors.orange
                    : Colors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
