import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla/Screens/Account%20/Account.dart';
import 'package:yalla/Screens/bottomnav/navigation.dart';
import 'package:yalla/Screens/home/home.dart';
import 'package:yalla/Screens/home/server.dart';
import 'package:yalla/Screens/home/speedtest.dart';
// Define these screens in their own files later if needed

class CustomSalomonNavigation extends StatefulWidget {
  const CustomSalomonNavigation({Key? key}) : super(key: key);

  @override
  State<CustomSalomonNavigation> createState() =>
      _CustomSalomonNavigationState();
}

class _CustomSalomonNavigationState extends State<CustomSalomonNavigation> {
  int _currentIndex = 1; // Start with Home selected

  final List<Widget> _screens = [
    const ServerScreen(),
    const HomeScreen(),
    const SpeedTestScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        top: false,
        bottom: true,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: SafeArea(
        left: false,
        right: false,
        top: false,
        bottom: true,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCustomNavItem(index: 0, icon: Icons.public, title: ''),
              _buildCustomNavItem(index: 1, icon: Icons.home, title: 'Home'),
              _buildCustomNavItem(index: 2, icon: Icons.flash_on, title: ''),
              _buildCustomNavItem(index: 3, icon: Icons.person, title: ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomNavItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSelected ? 80 : 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00417B) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
            ),
            if (title.isNotEmpty && isSelected) ...[
              const SizedBox(height: 2),
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// // Same placeholder screens as above...
// class ServersScreen extends StatelessWidget {
//   const ServersScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Servers',
//           style: GoogleFonts.nunitoSans(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF00417B),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Icon(Icons.public, size: 100, color: Color(0xFF00417B)),
//       ),
//     );
//   }
// }

// class SpeedTestScreen extends StatelessWidget {
//   const SpeedTestScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Speed Test',
//           style: GoogleFonts.nunitoSans(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF00417B),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Icon(Icons.flash_on, size: 100, color: Color(0xFF00417B)),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Profile',
//           style: GoogleFonts.nunitoSans(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF00417B),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Icon(Icons.person, size: 100, color: Color(0xFF00417B)),
//       ),
//     );
//   }
// }
