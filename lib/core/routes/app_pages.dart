// lib/core/routes/app_pages.dart (updated)
import 'package:get/get.dart';
import 'package:gitview/presentation/pages/home_page.dart';
import 'package:gitview/presentation/pages/repository_details_page.dart';
import 'package:gitview/presentation/pages/splash_screen.dart';
import 'package:gitview/presentation/pages/user_input_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/', page: () => const SplashPage()),
    GetPage(name: '/user-input', page: () => const UserInputPage()),
    GetPage(name: '/home', page: () => const HomePage()),
    GetPage(
      name: '/repository-details',
      page: () => const RepositoryDetailsPage(),
    ),
  ];
}
