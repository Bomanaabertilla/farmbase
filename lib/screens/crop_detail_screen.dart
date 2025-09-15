import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/crop.dart';
import '../providers/crop_provider.dart';
import 'add_crop_screen.dart';

class CropDetailScreen extends StatelessWidget {
  final Crop crop;
  const CropDetailScreen({super.key, required this.crop});

  void _deleteCrop(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Crop'),
        content: const Text('Are you sure you want to delete this crop?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirm == true) {
      await Provider.of<CropProvider>(context, listen: false).deleteCrop(crop.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${crop.name} deleted')));
    }
  }

  void _editCrop(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddCropScreen(editCrop: crop)),
    );
  }

  void _updateStatus(BuildContext context, CropStatus newStatus) async {
    await Provider.of<CropProvider>(context, listen: false).updateStatus(crop.id, newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status updated to ${cropStatusToString(newStatus)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.yMMMd();
    return Scaffold(
      appBar: AppBar(title: Text(crop.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Planting Date'),
              subtitle: Text(df.format(crop.plantingDate)),
            ),
            ListTile(
              title: const Text('Expected Harvest Date'),
              subtitle: Text(df.format(crop.expectedHarvestDate)),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(cropStatusToString(crop.status)),
              trailing: DropdownButton<CropStatus>(
                value: crop.status,
                items: CropStatus.values
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(cropStatusToString(s)),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) _updateStatus(context, val);
                },
              ),
            ),
            if (crop.notes.isNotEmpty)
              ListTile(
                title: const Text('Notes'),
                subtitle: Text(crop.notes),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _editCrop(context),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _deleteCrop(context),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
