// lib/core/dependency_injection.dart (updated)
import 'package:get/get.dart';
import 'package:gitview/core/network/dio_client.dart';
import 'package:gitview/data/repositories/github_repository_impl.dart';
import 'package:gitview/data/services/github_api_service.dart';
import 'package:gitview/domain/repositories/github_repository.dart';
import 'package:gitview/domain/usecases/get_repository_details_usecase.dart';
import 'package:gitview/domain/usecases/get_user_repositories_usecase.dart';
import 'package:gitview/domain/usecases/get_user_usecase.dart';
import 'package:gitview/presentation/controllers/home_controller.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';
import 'package:gitview/presentation/controllers/user_input_controller.dart';

class DependencyInjection {
  static void init() {
    // Network
    Get.lazyPut(() => DioClient());

    // Services
    Get.lazyPut(() => GitHubApiService(Get.find<DioClient>()));

    // Repositories
    Get.lazyPut<GitHubRepository>(
      () => GitHubRepositoryImpl(Get.find<GitHubApiService>()),
    );

    // Use Cases
    Get.lazyPut(() => GetUserUseCase(Get.find<GitHubRepository>()));
    Get.lazyPut(() => GetUserRepositoriesUseCase(Get.find<GitHubRepository>()));
    Get.lazyPut(
      () => GetRepositoryDetailsUseCase(Get.find<GitHubRepository>()),
    );

    // Controllers
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => UserInputController(Get.find<GetUserUseCase>()));
    Get.lazyPut(() => HomeController(Get.find<GetUserRepositoriesUseCase>()));
    // Remove the RepositoryDetailsController from here as we'll create it on demand
  }
}
