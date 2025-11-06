// lib/presentation/widgets/repository_list_item.dart (updated)
import 'package:flutter/material.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/date_formatter.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/domain/entities/repository.dart';

class RepositoryListItem extends StatelessWidget {
  final Repository repository;
  final VoidCallback onTap;

  const RepositoryListItem({
    super.key,
    required this.repository,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: context.responsive.symmetricPadding(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: context.responsive.allPadding(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      repository.name,
                      style: context.appText.titleMedium(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (repository.private)
                    Container(
                      padding: context.responsive.symmetricPadding(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Private',
                        style: context.appText.caption(color: Colors.orange),
                      ),
                    ),
                ],
              ),
              8.vs(context),
              Text(
                repository.description.isEmpty
                    ? 'No description available'
                    : repository.description,
                style: context.appText.bodyMedium(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              12.vs(context),
              Row(
                children: [
                  if (repository.language.isNotEmpty) ...[
                    Icon(
                      Icons.code,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    4.hs(context),
                    Text(
                      repository.language,
                      style: context.appText.bodySmall(),
                    ),
                    16.hs(context),
                  ],
                  Icon(
                    Icons.star_border,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  4.hs(context),
                  Text(
                    repository.stargazersCount.toString(),
                    style: context.appText.bodySmall(),
                  ),
                  16.hs(context),
                  Icon(
                    Icons.visibility,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  4.hs(context),
                  Text(
                    repository.watchersCount.toString(),
                    style: context.appText.bodySmall(),
                  ),
                  const Spacer(),
                  Text(
                    'Updated ${DateFormatter.formatRelativeDate(repository.updatedAt)}',
                    style: context.appText.caption(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
