import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button - Reduced padding
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18, // Reduced from 20
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Premium',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.daysOne(
                        fontSize: 20, // Reduced from 22
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18), // Reduced from 20
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ), // Reduced from 20
                child: Column(
                  children: [
                    const SizedBox(height: 25), // Reduced from 40
                    // Premium verified Icon with glow - Reduced size
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow effect
                        Container(
                          width: 150, // Reduced from 200
                          height: 150, // Reduced from 200
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFECF2F).withOpacity(0.3),
                                const Color(0xFFFECF2F).withOpacity(0.1),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.7, 1.0],
                            ),
                          ),
                        ),
                        // Main verified circle
                        Container(
                          width: 90, // Reduced from 120
                          height: 90, // Reduced from 120
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFECF2F), // Golden yellow
                                Color(0xFFF59E0B), // Darker yellow
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(45),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFECF2F).withOpacity(0.4),
                                blurRadius: 15, // Reduced from 20
                                offset: const Offset(0, 6), // Reduced from 8
                              ),
                            ],
                          ),
                          child:Center(child: Image.asset('assets/i.png',width: 40,height: 40,color: Colors.white,)),
                        ),
                        // Small shield icon
                        Positioned(
                          top: 15, // Reduced from 20
                          right: 30, // Reduced from 40
                          child: Container(
                            width: 32, // Reduced from 40
                            height: 32, // Reduced from 40
                            decoration: BoxDecoration(
                              color: const Color(0xFF00417B),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.security,
                              color: Colors.white,
                              size: 16, // Reduced from 20
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30), // Reduced from 40
                    // Main Title - Reduced size
                    Text(
                      'Unlock Elite VPN\nExperience',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 22, // Reduced from 28
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 35), // Reduced from 50
                    // Features List - Reduced spacing
                    _buildFeatureItem(
                      icon: Icons.flash_on,
                      iconColor: const Color(0xFFF59E0B),
                      iconBg: const Color(0xFFFEF3C7),
                      title: 'Ultra-Fast Speeds',
                      description: 'Up to 10x faster than free tier',
                      progressText: '1 Gbps',
                      progressColor: const Color(0xFFF59E0B),
                    ),

                    const SizedBox(height: 16), // Reduced from 20

                    _buildFeatureItem(
                      icon: Icons.public,
                      iconColor: const Color(0xFF0EA5E9),
                      iconBg: const Color(0xFFE0F2FE),
                      title: '23+ Global Servers',
                      description: 'Connect from anywhere, anytime',
                      extraInfo: '+32 more',
                      showFlags: true,
                    ),

                    const SizedBox(height: 16), // Reduced from 20

                    _buildFeatureItem(
                      icon: Icons.security,
                      iconColor: const Color(0xFF8B5CF6),
                      iconBg: const Color(0xFFF3E8FF),
                      title: 'Military-Grade Security',
                      description: 'AES-256 encryption & zero logs',
                      verified: true,
                    ),

                    const SizedBox(height: 16), // Reduced from 20

                    _buildFeatureItem(
                      icon: Icons.play_arrow,
                      iconColor: const Color(0xFFEF4444),
                      iconBg: const Color(0xFFFEE2E2),
                      title: 'Unlimited Streaming',
                      description: 'Netflix, Disney+, HBO & more',
                      extraInfo: '+ 10+ platforms',
                      showStreamingIcons: true,
                    ),

                    const SizedBox(height: 40), // Reduced from 60
                    // Continue Button - Reduced size
                    SizedBox(
                      width: double.infinity,
                      height: 48, // Reduced from 56
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumPlansScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00417B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              24,
                            ), // Reduced from 28
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16, // Reduced from 18
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Reduced from 30
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String description,
    String? progressText,
    Color? progressColor,
    String? extraInfo,
    bool showFlags = false,
    bool verified = false,
    bool showStreamingIcons = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16), // Reduced from 20
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12), // Reduced from 16
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6, // Reduced from 8
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40, // Reduced from 50
            height: 40, // Reduced from 50
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10), // Reduced from 12
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20, // Reduced from 24
            ),
          ),
          const SizedBox(width: 12), // Reduced from 16
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16, // Reduced from 18
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2), // Reduced from 4
                Text(
                  description,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 12, // Reduced from 14
                    color: Colors.grey[600],
                  ),
                ),
                if (progressText != null) ...[
                  const SizedBox(height: 6), // Reduced from 8
                  Container(
                    width: double.infinity,
                    height: 4, // Reduced from 6
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2), // Reduced from 4
                  Text(
                    progressText,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 10, // Reduced from 12
                      color: progressColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (showFlags) ...[
                  const SizedBox(height: 6), // Reduced from 8
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 8,
                        color: Colors.red,
                      ), // Reduced size
                      const SizedBox(width: 3), // Reduced from 4
                      Container(width: 12, height: 8, color: Colors.blue),
                      const SizedBox(width: 3),
                      Container(width: 12, height: 8, color: Colors.green),
                      const SizedBox(width: 6), // Reduced from 8
                      Text(
                        extraInfo ?? '',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 10, // Reduced from 12
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
                if (verified) ...[
                  const SizedBox(height: 6), // Reduced from 8
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 14,
                      ), // Reduced from 16
                      const SizedBox(width: 3), // Reduced from 4
                      Text(
                        'Verified Secure',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 10, // Reduced from 12
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (showStreamingIcons) ...[
                  const SizedBox(height: 6), // Reduced from 8
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.red,
                        size: 14,
                      ), // Reduced from 16
                      const SizedBox(width: 3), // Reduced from 4
                      Icon(Icons.video_library, color: Colors.red, size: 14),
                      const SizedBox(width: 6), // Reduced from 8
                      Text(
                        extraInfo ?? '',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 10, // Reduced from 12
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
            Center(child: Image.asset('assets/i.png',width: 20,height: 28,)),
        ],
      ),
    );
  }
}

// Premium Plans Screen (Second Screen) - Fixed gradient border for all plans
class PremiumPlansScreen extends StatefulWidget {
  const PremiumPlansScreen({Key? key}) : super(key: key);

  @override
  State<PremiumPlansScreen> createState() => _PremiumPlansScreenState();
}

class _PremiumPlansScreenState extends State<PremiumPlansScreen> {
  String _selectedPlan = 'Annual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Choose Your Plan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Annual Plan
                    _buildPlanCard(
                      planName: 'Annual Plan',
                      price: '\$2.99',
                      period: '/month',
                      originalPrice: '\$11.99/month',
                      billingInfo: 'Billed \$35.88 annually',
                      isSelected: _selectedPlan == 'Annual',
                      saveText: 'SAVE 60%',
                      onTap: () {
                        setState(() {
                          _selectedPlan = 'Annual';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Monthly Plan
                    _buildPlanCard(
                      planName: 'Monthly Plan',
                      price: '\$9.99',
                      period: '/month',
                      billingInfo: 'Billed monthly',
                      isSelected: _selectedPlan == 'Monthly',
                      onTap: () {
                        setState(() {
                          _selectedPlan = 'Monthly';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Weekly Plan
                    _buildPlanCard(
                      planName: 'Weekly Plan',
                      price: '\$9.99',
                      period: '/week',
                      billingInfo: 'Billed monthly',
                      isSelected: _selectedPlan == 'Weekly',
                      onTap: () {
                        setState(() {
                          _selectedPlan = 'Weekly';
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // Start Premium Trial Button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          _startPremiumTrial();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00417B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Start Premium Trial',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Trial Info
                    Text(
                      '7-day free trial • Cancel anytime',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '30-day money-back guarantee',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String planName,
    required String price,
    required String period,
    String? originalPrice,
    required String billingInfo,
    required bool isSelected,
    String? saveText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // FIXED: Apply gradient border to ANY selected plan
          border: isSelected
              ? const GradientBorder(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00417B), // Dark blue
                      Color(0xFFFECF2F), // Golden yellow
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  width: 2.5,
                )
              : Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  if (saveText != null) const SizedBox(height: 12),
                  Text(
                    planName,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        period,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  if (originalPrice != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      originalPrice,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    billingInfo,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 11,
                      color: originalPrice != null
                          ? Colors.green
                          : Colors.grey[600],
                      fontWeight: originalPrice != null
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // Show save badge only for Annual plan
              if (saveText != null && planName == 'Annual Plan')
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00417B), // Dark blue
                          Color(0xFFFECF2F), // Golden yellow
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      saveText,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

  void _startPremiumTrial() {
    // Create trial data with updated timestamp
    final trialData = {
      'plan': _selectedPlan,
      'user': 'uzairahmadaio',
      'timestamp': '2025-10-07 12:21:38',
      'trial_days': 7,
    };

    // Show success message
    Navigator.pop(context);
    Navigator.pop(context); // Go back to previous screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.verified, color: Colors.white, size: 16),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'Premium trial started for $_selectedPlan! Welcome to elite experience.',
                style: GoogleFonts.nunitoSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00417B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );

    print('Trial Data: $trialData'); // For debugging
  }
}

// Custom Gradient Border Widget (Fixed implementation)
class GradientBorder extends BoxBorder {
  const GradientBorder({required this.gradient, this.width = 1.0});

  final Gradient gradient;
  final double width;

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    switch (shape) {
      case BoxShape.circle:
        assert(
          borderRadius == null,
          'A borderRadius can only be given for rectangular boxes.',
        );
        _paintCircle(canvas, rect);
        break;
      case BoxShape.rectangle:
        if (borderRadius != null) {
          _paintRRect(canvas, rect, borderRadius);
          return;
        }
        _paintRect(canvas, rect);
        break;
    }
  }

  void _paintRect(Canvas canvas, Rect rect) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect.deflate(width / 2), paint);
  }

  void _paintRRect(Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final RRect rrect = borderRadius.toRRect(rect).deflate(width / 2);
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, paint);
  }

  void _paintCircle(Canvas canvas, Rect rect) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    final Offset center = rect.center;
    final double radius = (rect.shortestSide - width) / 2.0;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  ShapeBorder scale(double t) =>
      GradientBorder(gradient: gradient, width: width * t);
}
