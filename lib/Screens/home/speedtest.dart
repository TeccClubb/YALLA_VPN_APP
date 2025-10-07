import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math' as math;

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({Key? key}) : super(key: key);

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen>
    with TickerProviderStateMixin {
  late AnimationController _speedometerController;
  late AnimationController _pulseController;
  late Animation<double> _speedometerAnimation;
  late Animation<double> _pulseAnimation;

  bool _isTesting = false;
  double _currentSpeed = 0.0;
  double _uploadSpeed = 0.0;
  double _downloadSpeed = 0.0;
  String _pingTime = '00ms';
  String _jitterTime = '0ms';
  String _lossPercentage = '0 %';
  Timer? _testTimer;
  int _testDuration = 0;

  @override
  void initState() {
    super.initState();

    _speedometerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _speedometerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _speedometerController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _speedometerController.dispose();
    _pulseController.dispose();
    _testTimer?.cancel();
    super.dispose();
  }

  void _startSpeedTest() {
    setState(() {
      _isTesting = true;
      _currentSpeed = 0.0;
      _uploadSpeed = 0.0;
      _downloadSpeed = 0.0;
      _testDuration = 0;
    });

    _pulseController.repeat(reverse: true);

    // Simulate speed test
    _testTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _testDuration += 100;
        
        // Update ping, jitter during test
        if (_testDuration >= 1000) {
          _pingTime = '25ms';
          _jitterTime = '5ms';
        }

        // Simulate speed progression (0-10 seconds)
        if (_testDuration <= 10000) {
          // Create realistic speed curve
          double progress = _testDuration / 10000.0;
          double targetSpeed = 47.48; // Final speed from your image
          
          // Create a smooth curve with some randomness
          _currentSpeed = targetSpeed * progress + 
                         (math.Random().nextDouble() - 0.5) * 5;
          
          if (_currentSpeed < 0) _currentSpeed = 0;
          if (_currentSpeed > targetSpeed) _currentSpeed = targetSpeed;

          // Update speedometer animation
          _speedometerController.animateTo(progress);
        }

        // Test complete
        if (_testDuration >= 10000) {
          _completeSpeedTest();
        }
      });
    });
  }

  void _completeSpeedTest() {
    _testTimer?.cancel();
    _pulseController.stop();
    
    setState(() {
      _currentSpeed = 47.48;
      _uploadSpeed = 365.0;
      _downloadSpeed = 365.0;
    });
  }

  void _cancelSpeedTest() {
    _testTimer?.cancel();
    _pulseController.stop();
    _speedometerController.reset();
    
    setState(() {
      _isTesting = false;
      _currentSpeed = 0.0;
      _uploadSpeed = 0.0;
      _downloadSpeed = 0.0;
      _pingTime = '00ms';
      _jitterTime = '0ms';
      _testDuration = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header - Reduced padding
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Speed Test',
                    style: GoogleFonts.daysOne(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    size: 22,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Location and IP Info - Reduced spacing
         // Replace the Location and IP Info section with this styled version:

// Location and IP Info - Added background color and styling
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA), // Light gray background
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: GoogleFonts.nunitoSans(
                fontSize: 12,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'US - Miami',
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey[300],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'IP address',
              style: GoogleFonts.nunitoSans(
                fontSize: 12,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '198.162.88.1',
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),
            const SizedBox(height: 20),

            // Network Stats Row - Reduced size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    icon: Icons.wifi_tethering,
                    label: 'Ping $_pingTime',
                    color: Colors.grey[600]!,
                  ),
                  _buildStatItem(
                    icon: Icons.timeline,
                    label: 'Jitter $_jitterTime',
                    color: Colors.grey[600]!,
                  ),
                  _buildStatItem(
                    icon: Icons.signal_cellular_alt,
                    label: 'Loss $_lossPercentage',
                    color: Colors.grey[600]!,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Speedometer - INCREASED SIZE
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isTesting ? _pulseAnimation.value : 1.0,
                      child: SizedBox(
                        width: 350, // Increased from 300 to 350
                        height: 350, // Increased from 300 to 350
                        child: CustomPaint(
                          painter: SpeedometerPainter(
                            progress: _speedometerAnimation.value,
                            speed: _currentSpeed,
                            isTesting: _isTesting,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Upload/Download Speed Cards - Reduced size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSpeedCard(
                      icon: Icons.arrow_upward,
                      iconColor: Colors.orange,
                      title: 'Upload',
                      speed: _isTesting && _testDuration < 10000 
                        ? '00 Mb/s' 
                        : '${_uploadSpeed.toInt()} Mb/s',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSpeedCard(
                      icon: Icons.arrow_downward,
                      iconColor: Colors.green,
                      title: 'Download',
                      speed: _isTesting && _testDuration < 10000 
                        ? '00 Mb/s' 
                        : '${_downloadSpeed.toInt()} Mb/s',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Button - Reduced size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isTesting ? _cancelSpeedTest : _startSpeedTest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00417B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    _isTesting ? 'Cancel' : 'Speed Test Now',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.nunitoSans(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String speed,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                speed,
                style: GoogleFonts.nunitoSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  final double progress;
  final double speed;
  final bool isTesting;

  SpeedometerPainter({
    required this.progress,
    required this.speed,
    required this.isTesting,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 30; // Adjusted for larger size

    // Arc parameters - leaving gap at bottom like your image
    const double gapAngle = math.pi / 6; // 30 degrees gap at bottom
    const double startAngle = math.pi / 2 + gapAngle / 2; // Start from bottom-left
    const double totalSweep = 2 * math.pi - gapAngle; // Total arc minus gap

    // Background arc - #E5E7EB with REDUCED thickness
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8 // Reduced from 16 to 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweep,
      false,
      backgroundPaint,
    );

    // Progress arc with gradient - #0F2664 #FFFFFF #0F2664 with REDUCED thickness
    if (isTesting && progress > 0) {
      final double progressSweep = totalSweep * progress;
      
      // Create gradient shader
      final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
      final Gradient gradient = LinearGradient(
        colors: [
          const Color(0xFF0F2664), // Start color
          Colors.white,             // Middle color
          const Color(0xFF0F2664), // End color
        ],
        stops: const [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      
      final progressPaint = Paint()
        ..shader = gradient.createShader(arcRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8 // Reduced from 16 to 8
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        arcRect,
        startAngle,
        progressSweep,
        false,
        progressPaint,
      );
    }

    // Speed numbers INSIDE the circle with proper positioning
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    
    // Speed marks positioned according to the arc (not full circle)
    final List<Map<String, dynamic>> speedData = [
      {'value': '0', 'angle': startAngle}, // Start of arc
      {'value': '5', 'angle': startAngle + totalSweep * 0.05},
      {'value': '10', 'angle': startAngle + totalSweep * 0.15},
      {'value': '15', 'angle': startAngle + totalSweep * 0.25},
      {'value': '20', 'angle': startAngle + totalSweep * 0.35},
      {'value': '30', 'angle': startAngle + totalSweep * 0.5},
      {'value': '50', 'angle': startAngle + totalSweep * 0.7},
      {'value': '75', 'angle': startAngle + totalSweep * 0.85},
      {'value': '100', 'angle': startAngle + totalSweep * 0.95}, // Near end of arc
    ];

    for (var data in speedData) {
      final double angle = data['angle'] as double;
      final String value = data['value'] as String;
      
      // Position numbers INSIDE the circle
      final double numberRadius = radius - 25;
      final numberCenter = Offset(
        center.dx + numberRadius * math.cos(angle),
        center.dy + numberRadius * math.sin(angle),
      );

      textPainter.text = TextSpan(
        text: value,
        style: GoogleFonts.nunitoSans(
          fontSize: 16, // Slightly increased for larger speedometer
          color: const Color(0xFF6B7280),
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          numberCenter.dx - textPainter.width / 2,
          numberCenter.dy - textPainter.height / 2,
        ),
      );
    }

    // "Upload" text - positioned like your image
    textPainter.text = TextSpan(
      text: 'Upload',
      style: GoogleFonts.nunitoSans(
        fontSize: 18,
        color: const Color(0xFF9CA3AF),
        fontWeight: FontWeight.w400,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - 70,
      ),
    );

    // Center speed display - Larger for bigger speedometer
    textPainter.text = TextSpan(
      text: speed.toStringAsFixed(2),
      style: GoogleFonts.nunitoSans(
        fontSize: 48, // Increased for larger speedometer
        color: const Color(0xFF1F2937),
        fontWeight: FontWeight.w700,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2 - 5,
      ),
    );

    // "Mb/s" text
    textPainter.text = TextSpan(
      text: 'Mb/s',
      style: GoogleFonts.nunitoSans(
        fontSize: 18,
        color: const Color(0xFF9CA3AF),
        fontWeight: FontWeight.w500,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy + 30,
      ),
    );

    // Progress indicator dot - Slightly larger for bigger speedometer
    if (isTesting && progress > 0) {
      final double dotAngle = startAngle + totalSweep * progress;
      final dotCenter = Offset(
        center.dx + radius * math.cos(dotAngle),
        center.dy + radius * math.sin(dotAngle),
      );

      final dotPaint = Paint()
        ..color = const Color(0xFF0F2664)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(dotCenter, 10, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}