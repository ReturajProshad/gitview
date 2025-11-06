// lib/data/repositories/github_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/data/services/github_api_service.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/repositories/github_repository.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubApiService _apiService;

  GitHubRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, User>> getUser(String username) async {
    try {
      final userModel = await _apiService.getUser(username);
      return Right(userModel);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Repository>>> getUserRepositories(
    String username,
  ) async {
    try {
      final repositoryModels = await _apiService.getUserRepositories(username);
      return Right(repositoryModels.cast<Repository>());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Repository>> getRepositoryDetails(
    String owner,
    String repoName,
  ) async {
    try {
      final repositoryModel = await _apiService.getRepositoryDetails(
        owner,
        repoName,
      );
      return Right(repositoryModel);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
