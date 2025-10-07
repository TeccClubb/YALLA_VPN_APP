import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onborading.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
        );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Top section with Welcome text and logo
              Expanded(
                flex: 5,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome To text
                      Text(
                        'Welcome To',
                        style: GoogleFonts.daysOne(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C3E50),
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Your Yalla VPN Logo
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 260,
                          maxHeight: 90,
                        ),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _fadeController,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: Image.asset(
                            'assets/Logo (2).png', // Your logo path
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback if logo is not found
                              return Container(
                                width: 260,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F7FA),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE8EDF3),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 32,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Logo not found',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Features section
              Expanded(
                flex: 4,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeatureItem(
                          icon: Icons.flash_on,
                          title: 'Lightning Fast',
                          subtitle: 'Ultra-fast servers worldwide',
                        ),
                        const SizedBox(height: 20),
                        _buildFeatureItem(
                          icon: Icons.visibility_off,
                          title: 'No Logs Policy',
                          subtitle: 'We don\'t track or store your data',
                        ),
                        const SizedBox(height: 20),
                        _buildFeatureItem(
                          icon: Icons.devices,
                          title: 'Multi-Device',
                          subtitle: 'Use on all your devices simultaneously',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom section with Next button and terms
              Expanded(
                flex: 2,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Next Button
                        Container(
                          width: double.infinity,
                          height: 52,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to onboarding screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OnboardingScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00417B),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE5E7EB),
                                        shape: BoxShape.circle
                                      ),
                                    
                                      child: Icon(
                                        Icons.shield,
                                        size: 18,
                                        color: Color(0xFF00417B)
                                      ),
                                    ),
                                 
                                const SizedBox(width: 12),
                                Text(
                                  'Next',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                 ],
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Terms and Privacy Policy
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12,
                                  color: const Color(0xFF7C8591),
                                  height: 1.3,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'By continuing, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 12,
                                      color: const Color(0xFF00417B),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 12,
                                      color: const Color(0xFF00417B),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        // Icon container
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EDF3),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(icon, size: 22, color: const Color(0xFF00417B)),
        ),

        const SizedBox(width: 16),

        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C3E50),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.nunitoSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7C8591),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Alternative version without Google Fonts (to avoid plugin issues)
class WelcomeScreenNoGoogleFonts extends StatefulWidget {
  const WelcomeScreenNoGoogleFonts({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenNoGoogleFonts> createState() =>
      _WelcomeScreenNoGoogleFontsState();
}

class _WelcomeScreenNoGoogleFontsState extends State<WelcomeScreenNoGoogleFonts>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
        );

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // Top section with Welcome text and logo
                        Expanded(
                          flex: 5,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Welcome To',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2C3E50),
                                    letterSpacing: -0.5,
                                    fontFamily: 'System',
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Your Yalla VPN Logo
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 260,
                                    maxHeight: 90,
                                  ),
                                  child: ScaleTransition(
                                    scale: Tween<double>(begin: 0.8, end: 1.0)
                                        .animate(
                                          CurvedAnimation(
                                            parent: _fadeController,
                                            curve: Curves.elasticOut,
                                          ),
                                        ),
                                    child: Image.asset(
                                      'assets/Logo (2).png',
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.high,
                                      errorBuilder: (context, error, stackTrace) {
                                        // Fallback if logo is not found
                                        return Container(
                                          width: 260,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5F7FA),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE8EDF3),
                                              width: 2,
                                            ),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .image_not_supported_outlined,
                                                size: 32,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Logo not found',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Features section
                        Expanded(
                          flex: 4,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildFeatureItemNoFont(
                                    icon: Icons.flash_on,
                                    title: 'Lightning Fast',
                                    subtitle: 'Ultra-fast servers worldwide',
                                  ),
                                  const SizedBox(height: 20),
                                  _buildFeatureItemNoFont(
                                    icon: Icons.visibility_off,
                                    title: 'No Logs Policy',
                                    subtitle:
                                        'We don\'t track or store your data',
                                  ),
                                  const SizedBox(height: 20),
                                  _buildFeatureItemNoFont(
                                    icon: Icons.devices,
                                    title: 'Multi-Device',
                                    subtitle:
                                        'Use on all your devices simultaneously',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Bottom section
                        Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Next Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const OnboardingScreen(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF00417B,
                                        ),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shield_outlined, size: 22),
                                          SizedBox(width: 12),
                                          Text(
                                            'Next',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(Icons.arrow_forward, size: 18),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // Terms text
                                  const Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF7C8591),
                                        height: 1.3,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'By continuing, you agree to our ',
                                        ),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                            color: Color(0xFF00417B),
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: Color(0xFF00417B),
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureItemNoFont({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EDF3),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(icon, size: 22, color: const Color(0xFF00417B)),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7C8591),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
