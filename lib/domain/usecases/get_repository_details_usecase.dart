// lib/domain/usecases/get_repository_details_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/repositories/github_repository.dart';

class GetRepositoryDetailsUseCase {
  final GitHubRepository repository;

  GetRepositoryDetailsUseCase(this.repository);

  Future<Either<Failure, Repository>> execute(String owner, String repoName) async {
    if (owner.isEmpty || repoName.isEmpty) {
      return const Left(ServerFailure('Owner and repository name cannot be empty'));
    }
    return await repository.getRepositoryDetails(owner, repoName);
  }
}