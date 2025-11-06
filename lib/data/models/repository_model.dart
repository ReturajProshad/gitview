// lib/data/models/repository_model.dart
import 'package:gitview/domain/entities/repository.dart';

class RepositoryModel extends Repository {
  const RepositoryModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.description,
    required super.private,
    required super.fork,
    required super.htmlUrl,
    required super.cloneUrl,
    required super.sshUrl,
    required super.size,
    required super.stargazersCount,
    required super.watchersCount,
    required super.language,
    required super.hasIssues,
    required super.hasProjects,
    required super.hasWiki,
    required super.hasPages,
    required super.hasDownloads,
    required super.archived,
    required super.disabled,
    required super.pushedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.defaultBranch,
    required super.license,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      description: json['description'] ?? '',
      private: json['private'] ?? false,
      fork: json['fork'] ?? false,
      htmlUrl: json['html_url'] ?? '',
      cloneUrl: json['clone_url'] ?? '',
      sshUrl: json['ssh_url'] ?? '',
      size: json['size'] ?? 0,
      stargazersCount: json['stargazers_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      language: json['language'] ?? '',
      hasIssues: json['has_issues'] ?? false,
      hasProjects: json['has_projects'] ?? false,
      hasWiki: json['has_wiki'] ?? false,
      hasPages: json['has_pages'] ?? false,
      hasDownloads: json['has_downloads'] ?? false,
      archived: json['archived'] ?? false,
      disabled: json['disabled'] ?? false,
      pushedAt: json['pushed_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      defaultBranch: json['default_branch'] ?? '',
      license: json['license']?['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'private': private,
      'fork': fork,
      'html_url': htmlUrl,
      'clone_url': cloneUrl,
      'ssh_url': sshUrl,
      'size': size,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'language': language,
      'has_issues': hasIssues,
      'has_projects': hasProjects,
      'has_wiki': hasWiki,
      'has_pages': hasPages,
      'has_downloads': hasDownloads,
      'archived': archived,
      'disabled': disabled,
      'pushed_at': pushedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'default_branch': defaultBranch,
      // ignore: unnecessary_null_comparison
      'license': license != null ? {'key': license} : null,
    };
  }
}
