// lib/data/services/github_api_service.dart
import 'package:dio/dio.dart';
import 'package:gitview/core/errors/failures.dart';
import 'package:gitview/core/network/dio_client.dart';
import 'package:gitview/data/models/repository_model.dart';
import 'package:gitview/data/models/user_model.dart';

class GitHubApiService {
  final DioClient _dioClient;

  GitHubApiService(this._dioClient);

  Future<UserModel> getUser(String username) async {
    try {
      final response = await _dioClient.get('/users/$username');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw NotFoundFailure('User not found');
      } else {
        throw ServerFailure('Failed to fetch user data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundFailure('User not found');
      } else {
        throw ServerFailure('Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }

  Future<List<RepositoryModel>> getUserRepositories(String username) async {
    try {
      final response = await _dioClient.get('/users/$username/repos');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((repo) => RepositoryModel.fromJson(repo)).toList();
      } else if (response.statusCode == 404) {
        throw NotFoundFailure('User repositories not found');
      } else {
        throw ServerFailure('Failed to fetch repositories');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundFailure('User repositories not found');
      } else {
        throw ServerFailure('Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }

  Future<RepositoryModel> getRepositoryDetails(
    String owner,
    String repoName,
  ) async {
    try {
      final response = await _dioClient.get('/repos/$owner/$repoName');

      if (response.statusCode == 200) {
        return RepositoryModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw NotFoundFailure('Repository not found');
      } else {
        throw ServerFailure('Failed to fetch repository details');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkFailure('No internet connection');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundFailure('Repository not found');
      } else {
        throw ServerFailure('Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }
}
