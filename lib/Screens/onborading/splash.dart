import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _logoController;
  late Animation<double> _progressAnimation;
  late Animation<double> _logoAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Initialize logo fade-in animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Initialize progress animation
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Start animations with a slight delay
    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      _progressController.forward();
    });

    // Simulate loading process and navigate after 5 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      // Navigate to welcome screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _logoController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Main content area with logo only
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: Transform.scale(
                        scale: 0.8 + (_logoAnimation.value * 0.2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: _buildLogoOnly(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom section with progress bar and text
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                bottom: 60.0,
              ),
              child: Column(
                children: [
                  // Progress bar with custom colors
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        height: 6.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: const Color(0xFFD6D6D6), // Background color
                        ),
                        child: Stack(
                          children: [
                            // Background
                            Container(
                              width: double.infinity,
                              height: 6.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: const Color(
                                  0xFFD6D6D6,
                                ), // Background color
                              ),
                            ),
                            // Progress fill with custom gradient
                            Container(
                              width:
                                  MediaQuery.of(context).size.width *
                                  _progressAnimation.value,
                              height: 6.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0F2664), // Start color
                                    Color(0xFFFFFFFF), // Middle color (white)
                                    Color(0xFF0F2664), // End color
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 0.5, 1.0], // Color distribution
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16.0),

                  // Loading text
                  const Text(
                    'Initializing secure connection...',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoOnly() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 150),
      child: Image.asset(
        'assets/Logo (2).png', // Path to your logo image
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

// Alternative version with different gradient style
class AlternativeSplashScreen extends StatefulWidget {
  const AlternativeSplashScreen({Key? key}) : super(key: key);

  @override
  State<AlternativeSplashScreen> createState() =>
      _AlternativeSplashScreenState();
}

class _AlternativeSplashScreenState extends State<AlternativeSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _logoController;
  late Animation<double> _progressAnimation;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoAnimation.value,
                      child: Transform.scale(
                        scale: 0.8 + (_logoAnimation.value * 0.2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 300,
                              maxHeight: 150,
                            ),
                            child: Image.asset(
                              'assets/Logo (2).png',
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                bottom: 60.0,
              ),
              child: Column(
                children: [
                  // Progress bar with simpler gradient (if you prefer)
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        height: 6.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: const Color(0xFFD6D6D6),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              // Simple gradient from dark blue to lighter blue
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0F2664), Color(0xFF1A3A7A)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16.0),

                  const Text(
                    'Initializing secure connection...',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
