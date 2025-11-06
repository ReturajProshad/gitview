// lib/domain/repositories/github_repository.dart
import 'package:dartz/dartz.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';

abstract class GitHubRepository {
  Future<Either<Failure, User>> getUser(String username);
  Future<Either<Failure, List<Repository>>> getUserRepositories(
    String username,
  );
  Future<Either<Failure, Repository>> getRepositoryDetails(
    String owner,
    String repoName,
  );
}
