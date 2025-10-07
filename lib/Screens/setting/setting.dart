import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla/Screens/setting/feedback.dart';
import 'package:yalla/Screens/setting/premium.dart';
import 'package:yalla/Screens/setting/protocol.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _killSwitchEnabled = true;
  bool _autoConnectEnabled = false;
  bool _dnsLeakProtectionEnabled = true;
  bool _adTrackerBlockerEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Setting',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.daysOne(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20), // Balance the back button
                ],
              ),
            ),

            // Settings Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Connection Settings Section
                    _buildSectionHeader('Connection Settings'),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildSettingItem(
                            icon: Icons.hub_outlined,
                            title: 'Protocol Selection',
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Auto',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.chevron_right,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProtocolSelectionScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.power_settings_new,
                            title: 'Kill Switch',
                            trailing: CupertinoSwitch(
                              value: _killSwitchEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _killSwitchEnabled = value;
                                });
                              },
                              activeColor: const Color(
                                0xFF00417B,
                              ), // Blue switch
                            ),
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.rocket_launch_outlined,
                            title: 'Auto-Connect',
                            trailing: CupertinoSwitch(
                              value: _autoConnectEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _autoConnectEnabled = value;
                                });
                              },
                              activeColor: const Color(
                                0xFF00417B,
                              ), // Blue switch
                            ),
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.compare_arrows,
                            title: 'Split Tunneling',
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            onTap: () => _showSplitTunnelingDialog(),
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Privacy & Security Section
                    _buildSectionHeader('Privacy & Security'),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildSettingItem(
                            icon: Icons.security,
                            title: 'DNS Leak Protection',
                            trailing: CupertinoSwitch(
                              value: _dnsLeakProtectionEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _dnsLeakProtectionEnabled = value;
                                });
                              },
                              activeColor: const Color(
                                0xFF00417B,
                              ), // Blue switch
                            ),
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.block,
                            title: 'Ad & Tracker Blocker',
                            trailing: CupertinoSwitch(
                              value: _adTrackerBlockerEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _adTrackerBlockerEnabled = value;
                                });
                              },
                              activeColor: const Color(
                                0xFF00417B,
                              ), // Blue switch
                            ),
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Account & Support Section
                    _buildSectionHeader('Account & Support'),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildSettingItem(
                            icon: Icons.headphones,
                            title: 'FeedBack',
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FeedbackScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.workspace_premium,
                            title: 'Premium Plan',
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PremiumScreen(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildSettingItem(
                            icon: Icons.info_outline,
                            title: 'About App',
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'v1.0.0',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.chevron_right,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            onTap: () => _showAboutDialog(),
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Logout Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: OutlinedButton(
                        onPressed: () => _showLogoutDialog(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // App Version Footer
                    Center(
                      child: Text(
                        'YallaVPN v1.0.0',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00417B).withOpacity(0.2), // Very light blue
                    const Color(
                      0xFFFECF2F,
                    ).withOpacity(0.3), // Light golden yellow
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF00417B), // Keep icons blue
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 68),
      child: Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
    );
  }

  void _showProtocolDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Protocol Selection',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Auto (Recommended)',
                style: GoogleFonts.nunitoSans(),
              ),
              leading: Icon(Icons.auto_awesome, color: const Color(0xFF00417B)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('OpenVPN', style: GoogleFonts.nunitoSans()),
              leading: Icon(Icons.vpn_key, color: const Color(0xFF00417B)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('IKEv2', style: GoogleFonts.nunitoSans()),
              leading: Icon(Icons.security, color: const Color(0xFF00417B)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showSplitTunnelingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Split Tunneling',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Choose which apps use the VPN connection and which use your regular internet connection.',
          style: GoogleFonts.nunitoSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Configure',
              style: GoogleFonts.nunitoSans(color: const Color(0xFF00417B)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Send Feedback',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Tell us what you think...',
                border: const OutlineInputBorder(),
                hintStyle: GoogleFonts.nunitoSans(),
              ),
              maxLines: 3,
              style: GoogleFonts.nunitoSans(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.nunitoSans(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Feedback sent successfully!',
                    style: GoogleFonts.nunitoSans(),
                  ),
                  backgroundColor: const Color(0xFF00417B),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00417B),
            ),
            child: Text(
              'Send',
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showPremiumPlanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Premium Plan',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Upgrade to Premium for unlimited bandwidth, faster speeds, and access to all server locations.',
          style: GoogleFonts.nunitoSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Later',
              style: GoogleFonts.nunitoSans(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00417B),
            ),
            child: Text(
              'Upgrade',
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'About YallaVPN',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0', style: GoogleFonts.nunitoSans()),
            const SizedBox(height: 8),
            Text('Build Date: 2025-10-07', style: GoogleFonts.nunitoSans()),
            const SizedBox(height: 8),
            Text(
              'Build Time: 11:44:25 UTC',
              style: GoogleFonts.nunitoSans(),
            ), // Updated current time
            const SizedBox(height: 8),
            Text('User: uzairahmadaio', style: GoogleFonts.nunitoSans()),
            const SizedBox(height: 8),
            Text('Developer: YallaVPN Team', style: GoogleFonts.nunitoSans()),
            const SizedBox(height: 8),
            Text(
              '© 2025 YallaVPN. All rights reserved.',
              style: GoogleFonts.nunitoSans(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.nunitoSans(color: const Color(0xFF00417B)),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Logout',
          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to logout from your account (uzairahmadaio)?',
          style: GoogleFonts.nunitoSans(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.nunitoSans(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Logged out successfully!',
                    style: GoogleFonts.nunitoSans(),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Logout',
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
