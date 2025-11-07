// lib/presentation/controllers/user_input_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/usecases/get_user_usecase.dart';

class UserInputController extends GetxController {
  final GetUserUseCase _getUserUseCase;

  UserInputController(this._getUserUseCase);

  final usernameController = TextEditingController();
  final isLoading = false.obs;
  final user = Rxn<User>();
  final errorMessage = ''.obs;

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> fetchUser() async {
    if (usernameController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter a username';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getUserUseCase.execute(
      usernameController.text.trim(),
    );

    result.fold(
      (failure) => errorMessage.value = _mapFailureToMessage(failure),
      (user) {
        this.user.value = user;
        // Navigate to home page with user data
        Get.toNamed('/home', arguments: user);
      },
    );

    isLoading.value = false;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again later.';
      case NetworkFailure:
        return 'Network error. Please check your internet connection.';
      case NotFoundFailure:
        return 'User not found. Please check the username.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
