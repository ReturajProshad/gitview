// lib/presentation/models/repository_details_args.dart
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';

class RepositoryDetailsArgs {
  final User user;
  final Repository repository;

  const RepositoryDetailsArgs({required this.user, required this.repository});

  Map<String, dynamic> toMap() => {'user': user, 'repository': repository};

  factory RepositoryDetailsArgs.fromMap(Map<String, dynamic> map) {
    return RepositoryDetailsArgs(
      user: map['user'] as User,
      repository: map['repository'] as Repository,
    );
  }
}
