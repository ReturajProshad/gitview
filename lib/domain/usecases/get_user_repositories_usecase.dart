// lib/domain/usecases/get_user_repositories_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/repositories/github_repository.dart';

class GetUserRepositoriesUseCase {
  final GitHubRepository repository;

  GetUserRepositoriesUseCase(this.repository);

  Future<Either<Failure, List<Repository>>> execute(String username) async {
    if (username.isEmpty) {
      return const Left(ServerFailure('Username cannot be empty'));
    }
    return await repository.getUserRepositories(username);
  }
}
