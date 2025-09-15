import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../widgets/crop_tile.dart';
import '../models/crop.dart';
import 'add_crop_screen.dart';
import 'crop_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CropProvider>(context);
    final crops = _search.isEmpty ? provider.crops : provider.search(_search);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Crops'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search crops by name...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
        ),
      ),
      body: crops.isEmpty
          ? const Center(child: Text('No crops found. Add some using the + button'))
          : ListView.builder(
              itemCount: crops.length,
              itemBuilder: (context, idx) {
                final crop = crops[idx];
                return CropTile(
                  crop: crop,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CropDetailScreen(crop: crop)),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddCropScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
