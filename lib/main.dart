import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/storage_service.dart';
import 'providers/crop_provider.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CropApp());
}

class CropApp extends StatelessWidget {
  const CropApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();
    final authService = AuthService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = CropProvider(storage);
            provider.loadInitialData(); // load crops on startup
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final auth = AuthProvider(authService);
            auth.loadSession();
            return auth;
          },
        ),
      ],
      child: MaterialApp(
        title: 'FarmBase',
        theme: buildAppTheme(),
        home: const _Root(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (auth.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (auth.isAuthenticated) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
