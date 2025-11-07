// lib/presentation/controllers/repository_details_controller.dart

import 'package:get/get.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/usecases/get_repository_details_usecase.dart';
import 'package:gitview/presentation/model/repository_details_args.dart';

class RepositoryDetailsController extends GetxController {
  final GetRepositoryDetailsUseCase _getRepositoryDetailsUseCase;

  RepositoryDetailsController(this._getRepositoryDetailsUseCase);

  final isLoading = false.obs;
  final repository = Rxn<Repository>();
  final errorMessage = ''.obs;
  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // Get arguments
    if (Get.arguments != null) {
      final args = Get.arguments as RepositoryDetailsArgs;
      user.value = args.user;
      final repo = args.repository;

      // Fetch detailed repository information
      fetchRepositoryDetails(user.value!.login, repo.name);
    }
  }

  Future<void> fetchRepositoryDetails(String owner, String repoName) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getRepositoryDetailsUseCase.execute(owner, repoName);

    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (repo) => repository.value = repo,
    );

    isLoading.value = false;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server error. Please try again later.';
      case NetworkFailure _:
        return 'Network error. Please check your internet connection.';
      case NotFoundFailure _:
        return 'Repository not found.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
