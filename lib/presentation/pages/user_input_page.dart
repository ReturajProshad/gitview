// lib/presentation/pages/user_input_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/utils/app_text.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';
import 'package:gitview/presentation/controllers/user_input_controller.dart';

class UserInputPage extends StatelessWidget {
  const UserInputPage({super.key});

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
        child: Padding(
          padding: context.responsive.allPadding(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.vs(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
