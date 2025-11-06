// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gitview/core/di/dependency_injection.dart';
import 'package:gitview/core/routes/app_pages.dart';
import 'package:gitview/core/utils/app_theme.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';

void main() async {
  await GetStorage.init();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    
    return GetMaterialApp(
      title: 'GitHub Repo Viewer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}