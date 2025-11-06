// lib/presentation/controllers/home_controller.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gitview/core/constants/app_constants.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/usecases/get_user_repositories_usecase.dart';

enum SortOption { name, stars, updated, created }

class HomeController extends GetxController {
  final GetUserRepositoriesUseCase _getUserRepositoriesUseCase;

  HomeController(this._getUserRepositoriesUseCase);

  final _storage = GetStorage();
  final isLoading = false.obs;
  final repositories = <Repository>[].obs;
  final filteredRepositories = <Repository>[].obs;
  final errorMessage = ''.obs;
  final user = Rxn<User>();
  final isGridView = false.obs;
  final sortOption = SortOption.name.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get user from arguments
    if (Get.arguments != null) {
      user.value = Get.arguments as User;
      fetchUserRepositories();
    }

    // Load view preference
    isGridView.value = _storage.read(AppConstants.storageViewKey) ?? false;
  }

  Future<void> fetchUserRepositories() async {
    if (user.value == null) return;

    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getUserRepositoriesUseCase.execute(user.value!.login);

    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (repos) {
        repositories.value = repos;
        applyFilters();
      },
    );

    isLoading.value = false;
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
    _storage.write(AppConstants.storageViewKey, isGridView.value);
  }

  void setSortOption(SortOption option) {
    sortOption.value = option;
    applyFilters();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void applyFilters() {
    List<Repository> filtered = List.from(repositories);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      filtered =
          filtered
              .where(
                (repo) =>
                    repo.name.toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ||
                    (repo.description.isNotEmpty &&
                        repo.description.toLowerCase().contains(
                          searchQuery.value.toLowerCase(),
                        )),
              )
              .toList();
    }

    // Apply sorting
    switch (sortOption.value) {
      case SortOption.name:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.stars:
        filtered.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
        break;
      case SortOption.updated:
        filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case SortOption.created:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    filteredRepositories.value = filtered;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server error. Please try again later.';
      case NetworkFailure _:
        return 'Network error. Please check your internet connection.';
      case NotFoundFailure _:
        return 'Repositories not found.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
