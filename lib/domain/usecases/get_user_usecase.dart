// lib/domain/usecases/get_user_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/repositories/github_repository.dart';

class GetUserUseCase {
  final GitHubRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<Failure, User>> execute(String username) async {
    if (username.isEmpty) {
      return const Left(ServerFailure('Username cannot be empty'));
    }
    return await repository.getUser(username);
  }
}
