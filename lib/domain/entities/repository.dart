// lib/domain/entities/repository.dart
class Repository {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final bool private;
  final bool fork;
  final String htmlUrl;
  final String cloneUrl;
  final String sshUrl;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String language;
  final bool hasIssues;
  final bool hasProjects;
  final bool hasWiki;
  final bool hasPages;
  final bool hasDownloads;
  final bool archived;
  final bool disabled;
  final String pushedAt;
  final String createdAt;
  final String updatedAt;
  final String defaultBranch;
  final String license;

  const Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.private,
    required this.fork,
    required this.htmlUrl,
    required this.cloneUrl,
    required this.sshUrl,
    required this.size,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasWiki,
    required this.hasPages,
    required this.hasDownloads,
    required this.archived,
    required this.disabled,
    required this.pushedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.defaultBranch,
    required this.license,
  });
}
