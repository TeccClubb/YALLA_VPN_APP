import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _powerButtonController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  // Connection states: 0 = disconnected, 1 = connecting, 2 = connected
  int _connectionState = 0;
  Timer? _connectionTimer;
  Duration _connectionDuration = Duration.zero;

  // Mock data for upload/download speeds
  double _uploadSpeed = 365.0;
  double _downloadSpeed = 365.0;
  int _selectedServerIndex = 1; // Pakistan selected by default

  final List<ServerLocation> _servers = [
    ServerLocation(
      country: 'United State',
      flagAsset: 'assets/usa_flag.png',
      ping: '25ms',
      ip: '198.123.88.1',
      signalStrength: 4,
    ),
    ServerLocation(
      country: 'Pakistan',
      flagAsset: 'assets/pakistan_flag.png',
      ping: '35ms',
      ip: '198.123.88.1',
      signalStrength: 3,
    ),
    ServerLocation(
      country: 'Russia',
      flagAsset: 'assets/russia_flag.png',
      ping: '25ms',
      ip: '198.123.88.1',
      signalStrength: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _powerButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _powerButtonController, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _powerButtonController.dispose();
    _connectionTimer?.cancel();
    super.dispose();
  }

  void _toggleConnection() async {
    _powerButtonController.forward().then((_) {
      _powerButtonController.reverse();
    });

    if (_connectionState == 0) {
      // Start connecting
      setState(() {
        _connectionState = 1; // Connecting
      });

      // Simulate connection process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _connectionState = 2; // Connected
      });
      _startConnectionTimer();
    } else {
      // Disconnect
      _stopConnectionTimer();
      setState(() {
        _connectionState = 0; // Disconnected
      });
    }
  }

  void _startConnectionTimer() {
    _connectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _connectionDuration = Duration(seconds: timer.tick);
        // Simulate changing speeds
        _uploadSpeed = 365.0 + (timer.tick % 10) * 2;
        _downloadSpeed = 365.0 + (timer.tick % 8) * 3;
      });
    });
  }

  void _stopConnectionTimer() {
    _connectionTimer?.cancel();
    setState(() {
      _connectionDuration = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/world map.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with logo and settings
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // YolloVpn Logo
                    Image.asset(
                      'assets/Logo (2).png',
                      height: 35,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'YolloVpn',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF00417B),
                          ),
                        );
                      },
                    ),

                    // Settings Icon
                    IconButton(
                      onPressed: () {
                        // Handle settings
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF6B7280),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Upload/Download Speed Cards (only show when connected)
              if (_connectionState == 2) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSpeedCard(
                          icon: Icons.arrow_upward,
                          iconColor: Colors.orange,
                          title: 'Upload',
                          speed: '${_uploadSpeed.toInt()} Mb/s',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSpeedCard(
                          icon: Icons.arrow_downward,
                          iconColor: Colors.green,
                          title: 'Download',
                          speed: '${_downloadSpeed.toInt()} Mb/s',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight - 280),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        Text(
                          'Connection Time',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          _formatDuration(_connectionDuration),
                          style: GoogleFonts.nunitoSans(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF00417B),
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Power Button
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Outermost circle (very light gray)
                                      Container(
                                        width: 300,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFFE5E7EB,
                                          ).withOpacity(0.4),
                                          boxShadow: _connectionState == 2
                                              ? [
                                                  BoxShadow(
                                                    color: const Color(
                                                      0xFF00417B,
                                                    ).withOpacity(0.15),
                                                    blurRadius:
                                                        40 *
                                                        _pulseAnimation.value,
                                                    spreadRadius:
                                                        20 *
                                                        _pulseAnimation.value,
                                                  ),
                                                ]
                                              : [],
                                        ),
                                      ),

                                      // Second circle (light blue-gray)
                                      Container(
                                        width: 240,
                                        height: 240,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFFB8C5D1,
                                          ).withOpacity(0.7),
                                        ),
                                      ),

                                      // Main power button
                                      GestureDetector(
                                        onTap: _toggleConnection,
                                        child: Container(
                                          width: 120,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                const Color(0xFF1E40AF),
                                                const Color(0xFF1E3A8A),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              60,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(
                                                  0xFF1E3A8A,
                                                ).withOpacity(0.4),
                                                blurRadius: 20,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: _buildButtonContent(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 25),

                        // Connection Status
                        _buildConnectionStatus(),

                        // Protection message (only show when connected)
                        if (_connectionState == 2) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Your connection is protected',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),

              // Server Location Cards
              Container(
                height: 120,
                padding: const EdgeInsets.only(bottom: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _servers.length,
                  itemBuilder: (context, index) {
                    return _buildServerCard(
                      _servers[index],
                      index == _selectedServerIndex,
                      _connectionState == 2 && index == _selectedServerIndex,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (_connectionState == 2) {
      // Connected state - Show "Stop" button
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),

          Text(
            'Stop',
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.7),
            ),
          ),

          const Spacer(),

          // Three chevrons pointing up
          Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white.withOpacity(0.6),
                size: 18,
              ),
              Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white.withOpacity(0.4),
                size: 18,
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Power icon with circles at bottom
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 2,
                  ),
                ),
              ),
              Icon(Icons.power_settings_new, color: Colors.white, size: 24),
            ],
          ),

          const SizedBox(height: 20),
        ],
      );
    } else {
      // Disconnected/Connecting state - Show "Start" button
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),

          // Power icon with circles at top
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 2,
                  ),
                ),
              ),
              Icon(Icons.power_settings_new, color: Colors.white, size: 30),
            ],
          ),

          const Spacer(),

          // Three chevrons pointing down
          Column(
            children: [
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.6),
                size: 18,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.4),
                size: 18,
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            'Start',
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.7),
            ),
          ),

          const SizedBox(height: 20),
        ],
      );
    }
  }

  Widget _buildConnectionStatus() {
    Color statusColor;
    String statusText;

    switch (_connectionState) {
      case 1:
        statusColor = Colors.orange;
        statusText = 'Connecting...';
        break;
      case 2:
        statusColor = Colors.green;
        statusText = 'Connected';
        break;
      default:
        statusColor = Colors.red;
        statusText = 'Disconnected';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          statusText,
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: statusColor,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                speed,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServerCard(
    ServerLocation server,
    bool isSelected,
    bool isConnected,
  ) {
    return Container(
      width: 130,
      height: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isConnected ? const Color(0xFF00417B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected && !isConnected
            ? Border.all(color: const Color(0xFF00417B), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row with flag and signal
            Row(
              children: [
                // Flag Image
                Container(
                  width: 28,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset(
                      server.flagAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF00417B),
                          child: const Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(),

                // Connected badge or signal strength
                if (isConnected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Connected',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00417B),
                      ),
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(4, (index) {
                          return Container(
                            width: 2.5,
                            height: 6 + (index * 1.5),
                            margin: const EdgeInsets.only(left: 0.8),
                            decoration: BoxDecoration(
                              color: index < server.signalStrength
                                  ? Colors.green
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(1),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        server.ping,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 6),

            // Location label
            Text(
              'Location',
              style: GoogleFonts.nunitoSans(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: isConnected
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF6B7280),
              ),
            ),

            // Country name
            Flexible(
              child: Text(
                server.country,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isConnected ? Colors.white : const Color(0xFF1F2937),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 2),

            // IP address
            Text(
              'IP: ${server.ip}',
              style: GoogleFonts.nunitoSans(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: isConnected
                    ? Colors.white.withOpacity(0.7)
                    : const Color(0xFF6B7280),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class ServerLocation {
  final String country;
  final String flagAsset;
  final String ping;
  final String ip;
  final int signalStrength; // 1-4

  ServerLocation({
    required this.country,
    required this.flagAsset,
    required this.ping,
    required this.ip,
    required this.signalStrength,
  });
}
