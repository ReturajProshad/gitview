// lib/presentation/widgets/repository_grid_item.dart (updated)
import 'package:flutter/material.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/date_formatter.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/domain/entities/repository.dart';

class RepositoryGridItem extends StatelessWidget {
  final Repository repository;
  final VoidCallback onTap;

  const RepositoryGridItem({
    super.key,
    required this.repository,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
                      style: context.appText.titleSmall(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (repository.private)
                    Container(
                      padding: context.responsive.symmetricPadding(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'P',
                        style: context.appText.caption(color: Colors.orange),
                      ),
                    ),
                ],
              ),
              8.vs(context),
              Expanded(
                child: Text(
                  repository.description.isEmpty
                      ? 'No description'
                      : repository.description,
                  style: context.appText.bodySmall(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              8.vs(context),
              if (repository.language.isNotEmpty) ...[
                Container(
                  padding: context.responsive.symmetricPadding(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    repository.language,
                    style: context.appText.caption(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                8.vs(context),
              ],
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    size: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  2.hs(context),
                  Text(
                    repository.stargazersCount.toString(),
                    style: context.appText.caption(),
                  ),
                  const Spacer(),
                  Text(
                    DateFormatter.formatRelativeDate(repository.updatedAt),
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
