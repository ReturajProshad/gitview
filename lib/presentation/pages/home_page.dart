// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/domain/entities/repository.dart';
import 'package:gitview/presentation/controllers/home_controller.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';
import 'package:gitview/presentation/model/repository_details_args.dart';
import 'package:gitview/presentation/pages/repository_details_page.dart';
import 'package:gitview/presentation/widgets/loading_widget.dart';
import 'package:gitview/presentation/widgets/repository_grid_item.dart';
import 'package:gitview/presentation/widgets/repository_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void>? gotoRepoPage(HomeController controller, Repository repository) {
    return Get.to(
      () => const RepositoryDetailsPage(),
      arguments: RepositoryDetailsArgs(
        user: controller.user.value!,
        repository: repository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.user.value?.login ?? 'Repositories')),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isGridView.value ? Icons.view_list : Icons.grid_view,
              ),
              onPressed: controller.toggleView,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildUserInfo(context, controller),
          _buildSearchAndFilter(context, controller),
          Expanded(
            child: Obx(() {
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
              } else if (controller.filteredRepositories.isEmpty) {
                return Center(
                  child: Text(
                    'No repositories found',
                    style: context.appText.bodyMedium(),
                  ),
                );
              } else {
                return controller.isGridView.value
                    ? _buildGridView(context, controller.filteredRepositories)
                    : _buildListView(context, controller.filteredRepositories);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, HomeController controller) {
    return Obx(() {
      final user = controller.user.value;
      if (user == null) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        padding: context.responsive.allPadding(16),
        margin: context.responsive.allPadding(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            16.hs(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name.isEmpty ? user.login : user.name,
                    style: context.appText.titleMedium(),
                  ),
                  4.vs(context),
                  Text(
                    user.bio.isEmpty ? 'No bio available' : user.bio,
                    style: context.appText.bodySmall(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.vs(context),
                  Row(
                    children: [
                      _buildInfoItem(
                        context,
                        'Repos',
                        user.publicRepos.toString(),
                      ),
                      16.hs(context),
                      _buildInfoItem(
                        context,
                        'Followers',
                        user.followers.toString(),
                      ),
                      16.hs(context),
                      _buildInfoItem(
                        context,
                        'Following',
                        user.following.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: context.appText.titleSmall()),
        Text(label, style: context.appText.caption()),
      ],
    );
  }

  Widget _buildSearchAndFilter(
    BuildContext context,
    HomeController controller,
  ) {
    return Padding(
      padding: context.responsive.symmetricPadding(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            onChanged: controller.setSearchQuery,
            decoration: const InputDecoration(
              hintText: 'Search repositories...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          8.vs(context),
          Row(
            children: [
              Text('Sort by:', style: context.appText.bodyMedium()),
              8.hs(context),
              Expanded(
                child: Obx(
                  () => DropdownButton<SortOption>(
                    value: controller.sortOption.value,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                        value: SortOption.name,
                        child: Text('Name'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.stars,
                        child: Text('Stars'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.updated,
                        child: Text('Last Updated'),
                      ),
                      DropdownMenuItem(
                        value: SortOption.created,
                        child: Text('Created'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) controller.setSortOption(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // In _buildListView method:
  Widget _buildListView(BuildContext context, List<Repository> repositories) {
    final controller = Get.find<HomeController>();
    return ListView.builder(
      padding: context.responsive.symmetricPadding(horizontal: 16),
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repository = repositories[index];
        return RepositoryListItem(
          repository: repository,
          onTap: () => gotoRepoPage(controller, repository),
        );
      },
    );
  }

  // In _buildGridView method:
  Widget _buildGridView(BuildContext context, List<Repository> repositories) {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: context.responsive.allPadding(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          final repository = repositories[index];
          return RepositoryGridItem(
            repository: repository,
            onTap: () => gotoRepoPage(controller, repository),
          );
        },
      ),
    );
  }
}
