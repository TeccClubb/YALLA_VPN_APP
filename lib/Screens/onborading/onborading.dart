import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Auth/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int currentPage = 0;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Power Meets",
      thirdTitle: "Privacy",
      subtitle:
          "Unlock blazing speed with uncompromised security — crafted for those who demand the best.",
      illustration: OnboardingIllustration.powerMeetsPrivacy,
      imagePath: "assets/Frame 1261153865.png", // Your first image
    ),
    OnboardingData(
      title: "Unlimited Global",
      thirdTitle: "Access",
      subtitle:
          "Connect anywhere. Stream, browse, and explore the globe with unlimited freedom.",
      illustration: OnboardingIllustration.globalAccess,
      imagePath: "assets/Frame 1261153867.png", // Your second image
    ),
    OnboardingData(
      title: "Secure Every",
      thirdTitle: "Moment",
      subtitle:
          "Stay invisible premium privacy that never takes a break. One tap, total peace of mind.", 
      illustration: OnboardingIllustration.secureEveryMoment,
      imagePath: "assets/Group 1261153867.png", // Your third image
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 24),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8A8A8A),
                    ),
                  ),
                ),
              ),
            ),

            // PageView for onboarding content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                  // Restart animation for each page
                  _animationController.reset();
                  _animationController.forward();
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    data: onboardingPages[index],
                    animation: _animationController,
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < onboardingPages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Navigate to login screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00417B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
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
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingData data;
  final AnimationController animation;

  const OnboardingPageWidget({
    Key? key,
    required this.data,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Title (first line)
          FadeTransition(
            opacity: animation,
            child: Text(
              data.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.daysOne(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C3E50),
                height: 1.1,
                letterSpacing: -0.8,
              ),
            ),
          ),

          // Title (second line with different color)
          FadeTransition(
            opacity: animation,
            child: Text(
              data.thirdTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.daysOne(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF00417B),
                height: 1.1,
                letterSpacing: -0.8,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Subtitle
          FadeTransition(
            opacity: animation,
            child: Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7C8591),
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Illustration using your provided images
          Expanded(
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                  ),
              child: FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: _buildImageIllustration(data.imagePath),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageIllustration(String imagePath) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 300),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stackTrace) {
              // Fallback if image is not found
              return Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE8EDF3), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Image not found\n$imagePath',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 14,
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
    );
  }
}

// Enhanced version with image preloading and better animations
class EnhancedOnboardingPageWidget extends StatefulWidget {
  final OnboardingData data;
  final AnimationController animation;

  const EnhancedOnboardingPageWidget({
    Key? key,
    required this.data,
    required this.animation,
  }) : super(key: key);

  @override
  State<EnhancedOnboardingPageWidget> createState() =>
      _EnhancedOnboardingPageWidgetState();
}

class _EnhancedOnboardingPageWidgetState
    extends State<EnhancedOnboardingPageWidget> {
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _preloadImage();
  }

  void _preloadImage() {
    final image = AssetImage(widget.data.imagePath);
    final imageStream = image.resolve(ImageConfiguration.empty);
    imageStream.addListener(
      ImageStreamListener((info, call) {
        if (mounted) {
          setState(() {
            _imageLoaded = true;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Title with enhanced animation (first line)
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: widget.animation,
                    curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
                  ),
                ),
            child: FadeTransition(
              opacity: widget.animation,
              child: Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.daysOne(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF21344F),
                  height: 1.1,
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ),

          // Title with enhanced animation (second line)
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: widget.animation,
                    curve: const Interval(0.1, 0.7, curve: Curves.easeOutCubic),
                  ),
                ),
            child: FadeTransition(
              opacity: widget.animation,
              child: Text(
                widget.data.thirdTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.daysOne(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00417B),
                  height: 1.1,
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Subtitle with enhanced animation
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: widget.animation,
                    curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
                  ),
                ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: widget.animation,
                curve: const Interval(0.2, 1.0),
              ),
              child: Text(
                widget.data.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7C8591),
                  height: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Enhanced image illustration
          Expanded(
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.7, end: 1.0).animate(
                CurvedAnimation(
                  parent: widget.animation,
                  curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
                ),
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: widget.animation,
                  curve: const Interval(0.4, 1.0),
                ),
                child: _buildEnhancedImageIllustration(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedImageIllustration() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background with subtle shadow
            Container(
              width: 340,
              height: 290,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),

            // Main image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AnimatedOpacity(
                opacity: _imageLoaded ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  widget.data.imagePath,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildErrorPlaceholder();
                  },
                ),
              ),
            ),

            // Loading indicator
            if (!_imageLoaded)
              Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00417B),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: 300,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EDF3), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Please add image:\n${widget.data.imagePath}',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// FIXED: Data classes with thirdTitle property
class OnboardingData {
  final String title;
  final String thirdTitle; // Added this missing property
  final String subtitle;
  final OnboardingIllustration illustration;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.thirdTitle, // Added this required parameter
    required this.subtitle,
    required this.illustration,
    required this.imagePath,
  });
}

enum OnboardingIllustration {
  powerMeetsPrivacy,
  globalAccess,
  secureEveryMoment,
}
