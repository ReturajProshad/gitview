// lib/presentation/pages/splash_page.dart (updated)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview/core/utils/responsive.dart';
import 'package:gitview/presentation/pages/user_input_page.dart';
import 'package:gitview/presentation/controllers/theme_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _navigateToHome();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Progress animation controller
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Logo opacity animation
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Text opacity animation
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Text slide animation
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // Progress animation
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    // Start logo animation
    _logoController.forward();

    // Wait for logo animation to complete, then start text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Start progress animation
    _progressController.forward();
  }

  void _navigateToHome() {
    // Navigate to home page after all animations complete
    Timer(const Duration(seconds: 3), () {
      Get.off(() => const UserInputPage());
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with animation
            AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Opacity(
                    opacity: _logoOpacityAnimation.value,
                    child: _buildLogo(context),
                  ),
                );
              },
            ),

            40.vs(context),

            // App name with animation
            AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: _buildAppName(context),
                  ),
                );
              },
            ),

            60.vs(context),

            // Progress indicator with animation
            AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return _buildProgressIndicator(context);
              },
            ),

            20.vs(context),

            // Loading text with animation
            AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _textOpacityAnimation,
                  child: _buildLoadingText(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return Container(
      width: context.responsive.scaleWidth(120),
      height: context.responsive.scaleWidth(120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors:
              isDarkMode
                  ? [const Color(0xFF536DFE), const Color(0xFF3F51B5)]
                  : [const Color(0xFF3F51B5), const Color(0xFF7986CB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode
                    ? const Color(0xFF536DFE).withValues(alpha: 0.3)
                    : const Color(0xFF3F51B5).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(Icons.code, color: Colors.white, size: 60),
    );
  }

  Widget _buildAppName(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return Column(
      children: [
        Text(
          'GitView',
          style: TextStyle(
            fontSize: context.responsive.fontSize(32),
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xFF212121),
            letterSpacing: 1.2,
          ),
        ),
        8.vs(context),
        Text(
          'Explore GitHub Repositories',
          style: TextStyle(
            fontSize: context.responsive.fontSize(16),
            color: isDarkMode ? Colors.white70 : const Color(0xFF757575),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return SizedBox(
      width: context.responsive.scaleWidth(200),
      child: LinearProgressIndicator(
        value: _progressAnimation.value,
        backgroundColor:
            isDarkMode
                ? Colors.white.withValues(alpha: 0.2)
                : const Color(0xFFE0E0E0),
        valueColor: AlwaysStoppedAnimation<Color>(
          isDarkMode ? const Color(0xFF536DFE) : const Color(0xFF3F51B5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildLoadingText(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        'Loading amazing repositories...',
        key: ValueKey(_progressAnimation.value > 0.5 ? 'loading' : 'init'),
        style: TextStyle(
          fontSize: context.responsive.fontSize(14),
          color: isDarkMode ? Colors.white70 : const Color(0xFF757575),
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
