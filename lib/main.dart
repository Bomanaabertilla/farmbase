import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/storage_service.dart';
import 'providers/crop_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CropApp());
}

class CropApp extends StatelessWidget {
  const CropApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = CropProvider(storage);
            provider.loadInitialData(); // load crops on startup
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Crop Manager',
        theme: buildAppTheme(),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
