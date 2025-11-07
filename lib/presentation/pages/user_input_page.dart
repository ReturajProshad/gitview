// lib/presentation/pages/user_input_page.dart (updated)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';
import 'package:gitview/presentation/controllers/user_input_controller.dart';

class UserInputPage extends StatelessWidget {
  const UserInputPage({super.key});

  // List of popular Flutter developers to suggest
  final List<Map<String, String>> flutterDevelopers = const [
    {
      'username': 'iampawan',
      'name': 'Pawan Kumar',
      'description': 'Flutter & Dart GDE',
    },
    {
      'username': 'Solido',
      'name': 'Simon Lightfoot',
      'description': 'Flutter GDE & Author',
    },
    {
      'username': 'flutter',
      'name': 'Flutter Team',
      'description': 'Official Flutter Account',
    },
    {
      'username': 'flutterdev',
      'name': 'Flutter Dev',
      'description': 'Flutter Community',
    },
    {
      'username': 'bizz84',
      'name': 'Andrea Bizzotto',
      'description': 'Flutter Author & Educator',
    },
    {
      'username': 'mitesh77',
      'name': 'Mitesh Chodvadiya',
      'description': 'Flutter GDE',
    },
    {
      'username': 'robertbrunhage',
      'name': 'Robert Brunhage',
      'description': 'Flutter Content Creator',
    },
    {
      'username': 'VandadNP',
      'name': 'Vandad Nahavandipoor',
      'description': 'Flutter & Swift Author',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserInputController(Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo Viewer'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: context.responsive.allPadding(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.vs(context),
                Text(
                  'Explore GitHub Profiles',
                  style: context.appText.titleLarge(),
                ),
                8.vs(context),
                Text(
                  'Enter a username or choose from popular Flutter developers',
                  style: context.appText.bodyMedium(),
                ),
                40.vs(context),
                Text('GitHub Username', style: context.appText.titleMedium()),
                10.vs(context),
                TextField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter GitHub username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onSubmitted: (_) {
                    controller.fetchUser();
                    controller.usernameController.clear();
                  },
                ),
                20.vs(context),
                Obx(
                  () => Text(
                    controller.errorMessage.value,
                    style: context.appText.bodySmall(color: Colors.red),
                  ),
                ),
                30.vs(context),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.fetchUser,
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text('Fetch User'),
                    ),
                  ),
                ),
                40.vs(context),
                Text(
                  'Popular Flutter Developers',
                  style: context.appText.titleMedium(),
                ),
                16.vs(context),
                _buildDeveloperSuggestions(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperSuggestions(
    BuildContext context,
    UserInputController controller,
  ) {
    return Column(
      children: [
        // First row of developers
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              flutterDevelopers.take(4).map((developer) {
                return _buildDeveloperCard(context, controller, developer);
              }).toList(),
        ),
        16.vs(context),
        // Second row of developers
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              flutterDevelopers.skip(4).map((developer) {
                return _buildDeveloperCard(context, controller, developer);
              }).toList(),
        ),
        24.vs(context),
        // Explore more button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _showMoreDevelopers(context, controller);
            },
            icon: const Icon(Icons.explore),
            label: const Text('Explore More Developers'),
          ),
        ),
      ],
    );
  }

  Widget _buildDeveloperCard(
    BuildContext context,
    UserInputController controller,
    Map<String, String> developer,
  ) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return GestureDetector(
      onTap: () {
        controller.usernameController.text = developer['username']!;
        controller.fetchUser();
        controller.usernameController.clear();
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 64) / 2,
        padding: context.responsive.allPadding(12),
        decoration: BoxDecoration(
          color:
              isDarkMode
                  ? Theme.of(context).colorScheme.surface
                  : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      isDarkMode
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFF3F51B5),
                  child: Text(
                    developer['name']![0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                8.hs(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        developer['name']!,
                        style: context.appText.titleSmall(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '@${developer['username']}',
                        style: context.appText.caption(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.vs(context),
            Text(
              developer['description']!,
              style: context.appText.bodySmall(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreDevelopers(
    BuildContext context,
    UserInputController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: context.responsive.allPadding(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'More Flutter Developers',
                        style: context.appText.titleLarge(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  16.vs(context),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: flutterDevelopers.length,
                      itemBuilder: (context, index) {
                        final developer = flutterDevelopers[index];
                        return ListTile(
                          contentPadding: context.responsive.symmetricPadding(
                            vertical: 8,
                            horizontal: 0,
                          ),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              developer['name']![0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            developer['name']!,
                            style: context.appText.titleSmall(),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '@${developer['username']}',
                                style: context.appText.bodySmall(),
                              ),
                              Text(
                                developer['description']!,
                                style: context.appText.bodySmall(),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            controller.usernameController.text =
                                developer['username']!;
                            controller.fetchUser();
                            controller.usernameController.clear();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
