// lib/domain/entities/user.dart
class User {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final String bio;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.bio,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
  });
}
