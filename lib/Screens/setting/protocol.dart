import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ProtocolSelectionScreen extends StatefulWidget {
  const ProtocolSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ProtocolSelectionScreen> createState() =>
      _ProtocolSelectionScreenState();
}

class _ProtocolSelectionScreenState extends State<ProtocolSelectionScreen> {
  bool _autoSelectProtocol = true;
  String _selectedProtocol = 'Wireguard';

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
                      size: 18,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Select Protocol',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18), // Balance the back button
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Auto Select Protocol Section - Reduced size
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00417B),
                              borderRadius: BorderRadius.circular(22.5),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Auto Select Protocol',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Let Yalla VPN choose the best protocol',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: _autoSelectProtocol,
                              onChanged: (value) {
                                setState(() {
                                  _autoSelectProtocol = value;
                                });
                              },
                              activeColor: const Color(0xFF00417B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Available Protocol Section Header - Reduced size
                    Text(
                      'Available Protocol',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Wireguard Protocol
                    _buildProtocolItem(
                      icon: Icons.flash_on,
                      iconColor: const Color(0xFF00417B),
                      title: 'Wireguard',
                      description: 'Fast and secure modern protocol',
                      isSelected: _selectedProtocol == 'Wireguard',
                      features: [
                        _buildFeature(
                          Icons.flash_on,
                          'Ultra Fast',
                          'Speed',
                          const Color(0xFF00417B),
                        ),
                        _buildFeature(
                          Icons.security,
                          'High',
                          'Security',
                          const Color(0xFF10B981),
                        ),
                      ],
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'Wireguard';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Sing-Box Protocol
                    _buildProtocolItem(
                      icon: Icons.security,
                      iconColor: const Color(0xFF00417B),
                      title: 'Sing-Box',
                      description: 'Reliable and widely supported',
                      isSelected: _selectedProtocol == 'Sing-Box',
                      features: [
                        _buildFeature(
                          Icons.shield,
                          'High Security',
                          'Protection',
                          const Color(0xFF10B981),
                        ),
                        _buildFeature(
                          Icons.public,
                          'Wide Support',
                          'Compatibility',
                          const Color(0xFF8B5CF6),
                        ),
                      ],
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'Sing-Box';
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Open Web Protocol
                    _buildProtocolItem(
                      icon: Icons.public,
                      iconColor: const Color(0xFF00417B),
                      title: 'Open Web',
                      description: 'Next - generation vpn Protocol',
                      isSelected: _selectedProtocol == 'Open Web',
                      features: [
                        _buildFeature(
                          Icons.rocket_launch,
                          'Next-Gen',
                          'Technology',
                          const Color(0xFFF59E0B),
                        ),
                        _buildFeature(
                          Icons.language,
                          'Open Source',
                          'Protocol',
                          const Color(0xFF06B6D4),
                        ),
                      ],
                      onTap: () {
                        setState(() {
                          _selectedProtocol = 'Open Web';
                        });
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
    List<Widget>? features,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                const Color(0xFF00417B).withOpacity(0.2),
                                const Color(0xFFFECF2F).withOpacity(0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF00417B)
                          : Colors.transparent,
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey[400]!, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 14)
                        : null,
                  ),
                ],
              ),
              // Show features only when selected
              if (isSelected && features != null && features.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: features[0]),
                      if (features.length > 1) ...[
                        const SizedBox(width: 12),
                        Expanded(child: features[1]),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.nunitoSans(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Gradient Border Widget
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
