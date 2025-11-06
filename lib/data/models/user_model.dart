// lib/data/models/user_model.dart

import 'package:gitview/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.login,
    required super.id,
    required super.avatarUrl,
    required super.htmlUrl,
    required super.name,
    required super.company,
    required super.blog,
    required super.location,
    required super.email,
    required super.bio,
    required super.publicRepos,
    required super.publicGists,
    required super.followers,
    required super.following,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      name: json['name'] ?? '',
      company: json['company'] ?? '',
      blog: json['blog'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      publicGists: json['public_gists'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'name': name,
      'company': company,
      'blog': blog,
      'location': location,
      'email': email,
      'bio': bio,
      'public_repos': publicRepos,
      'public_gists': publicGists,
      'followers': followers,
      'following': following,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
