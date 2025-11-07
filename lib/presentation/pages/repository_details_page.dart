// lib/presentation/pages/repository_details_page.dart (alternative approach)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/date_formatter.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/domain/entities/user.dart';
import 'package:gitview/domain/usecases/get_repository_details_usecase.dart';
import 'package:gitview/presentation/controllers/repository_details_controller.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';
import 'package:gitview/presentation/widgets/loading_widget.dart';

class RepositoryDetailsPage extends StatefulWidget {
  const RepositoryDetailsPage({super.key});

  @override
  State<RepositoryDetailsPage> createState() => _RepositoryDetailsPageState();
}

class _RepositoryDetailsPageState extends State<RepositoryDetailsPage> {
  late RepositoryDetailsController controller;
  late User user;
  late Repository repository;
  // Get arguments first
  final args = Get.arguments as Map<String, dynamic>?;

  @override
  void initState() {
    user = args?['user'] as User;
    repository = args?['repository'] as Repository;
    controller = Get.put(
      RepositoryDetailsController(GetRepositoryDetailsUseCase(Get.find())),
      tag: '${user.login}/${repository.name}',
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: _buildBody(context, controller, user, repository),
    );
  }

  Widget _buildBody(
    BuildContext context,
    RepositoryDetailsController controller,
    User user,
    Repository repository,
  ) {
    // Only fetch details if not already loading and repository is not set
    if (!controller.isLoading.value && controller.repository.value == null) {
      controller.fetchRepositoryDetails(user.login, repository.name);
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingWidget();
      } else if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: context.appText.bodyMedium(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      } else if (controller.repository.value == null) {
        return Center(
          child: Text(
            'Repository details not available',
            style: context.appText.bodyMedium(),
          ),
        );
      } else {
        return _buildRepositoryDetails(context, controller);
      }
    });
  }

  Widget _buildRepositoryDetails(
    BuildContext context,
    RepositoryDetailsController controller,
  ) {
    final repository = controller.repository.value!;

    return SingleChildScrollView(
      padding: context.responsive.allPadding(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repository.name, style: context.appText.titleLarge()),
          8.vs(context),
          Text(
            repository.fullName,
            style: context.appText.bodyMedium(color: Colors.grey),
          ),
          16.vs(context),
          Text(
            repository.description.isEmpty
                ? 'No description available'
                : repository.description,
            style: context.appText.bodyMedium(),
          ),
          24.vs(context),
          _buildInfoCard(context, 'Repository Information', [
            _buildInfoRow(
              context,
              'Language',
              repository.language.isEmpty
                  ? 'Not specified'
                  : repository.language,
            ),
            _buildInfoRow(context, 'Size', '${repository.size} KB'),
            _buildInfoRow(context, 'Default Branch', repository.defaultBranch),
            _buildInfoRow(
              context,
              'License',
              repository.license.isEmpty ? 'No license' : repository.license,
            ),
            _buildInfoRow(
              context,
              'Private',
              repository.private ? 'Yes' : 'No',
            ),
            _buildInfoRow(context, 'Fork', repository.fork ? 'Yes' : 'No'),
            _buildInfoRow(
              context,
              'Archived',
              repository.archived ? 'Yes' : 'No',
            ),
          ]),
          16.vs(context),
          _buildInfoCard(context, 'Statistics', [
            _buildInfoRow(
              context,
              'Stars',
              repository.stargazersCount.toString(),
            ),
            _buildInfoRow(
              context,
              'Watchers',
              repository.watchersCount.toString(),
            ),
          ]),
          16.vs(context),
          _buildInfoCard(context, 'Features', [
            _buildInfoRow(
              context,
              'Issues',
              repository.hasIssues ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              context,
              'Projects',
              repository.hasProjects ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              context,
              'Wiki',
              repository.hasWiki ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              context,
              'Pages',
              repository.hasPages ? 'Enabled' : 'Disabled',
            ),
            _buildInfoRow(
              context,
              'Downloads',
              repository.hasDownloads ? 'Enabled' : 'Disabled',
            ),
          ]),
          16.vs(context),
          _buildInfoCard(context, 'Dates', [
            _buildInfoRow(
              context,
              'Created',
              DateFormatter.formatDate(repository.createdAt),
            ),
            _buildInfoRow(
              context,
              'Updated',
              DateFormatter.formatDate(repository.updatedAt),
            ),
            _buildInfoRow(
              context,
              'Pushed',
              DateFormatter.formatDate(repository.pushedAt),
            ),
          ]),
          24.vs(context),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Open repository in browser
                // We could use the url_launcher package for this
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in Browser'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: context.responsive.allPadding(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.appText.titleMedium()),
            12.vs(context),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: context.responsive.symmetricPadding(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: context.appText.bodyMedium(weight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value, style: context.appText.bodyMedium())),
        ],
      ),
    );
  }
}
