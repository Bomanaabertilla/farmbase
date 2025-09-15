import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../models/crop.dart';

class AddCropScreen extends StatefulWidget {
  final Crop? editCrop;
  const AddCropScreen({super.key, this.editCrop});

  @override
  State<AddCropScreen> createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  DateTime? _plantingDate;
  DateTime? _harvestDate;

  @override
  void initState() {
    super.initState();
    if (widget.editCrop != null) {
      _nameCtrl.text = widget.editCrop!.name;
      _notesCtrl.text = widget.editCrop!.notes;
      _plantingDate = widget.editCrop!.plantingDate;
      _harvestDate = widget.editCrop!.expectedHarvestDate;
    }
  }

  Future<void> _pickDate(BuildContext context, bool isPlanting) async {
    final now = DateTime.now();
    final initialDate = isPlanting
        ? (_plantingDate ?? now)
        : (_harvestDate ?? now.add(const Duration(days: 30)));
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isPlanting) {
          _plantingDate = picked;
        } else {
          _harvestDate = picked;
        }
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final crop = Crop(
      id: widget.editCrop?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      plantingDate: _plantingDate!,
      expectedHarvestDate: _harvestDate!,
      notes: _notesCtrl.text.trim(),
      status: widget.editCrop?.status ?? CropStatus.growing,
    );

    final provider = Provider.of<CropProvider>(context, listen: false);
    if (widget.editCrop == null) {
      provider.addCrop(crop);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crop added successfully!')),
      );
    } else {
      provider.updateCrop(crop);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crop updated successfully!')),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.editCrop == null ? 'Add Crop' : 'Edit Crop')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Crop Name'),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter crop name' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_plantingDate == null
                    ? 'Pick Planting Date'
                    : 'Planting: ${_plantingDate!.toLocal().toString().split(" ")[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, true),
              ),
              ListTile(
                title: Text(_harvestDate == null
                    ? 'Pick Expected Harvest Date'
                    : 'Harvest: ${_harvestDate!.toLocal().toString().split(" ")[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, false),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: Text(widget.editCrop == null ? 'Save Crop' : 'Update Crop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
