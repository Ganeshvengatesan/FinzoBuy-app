import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ModaApp());
}

class ModaApp extends StatelessWidget {
  const ModaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Enforce light theme only
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
