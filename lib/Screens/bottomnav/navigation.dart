import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalla/Screens/home/home.dart';
// import 'home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 1; // Start with Home selected

  final List<TabItem> items = [
    const TabItem(icon: Icons.public, title: 'Servers'),
    const TabItem(icon: Icons.home, title: 'Home'),
    const TabItem(icon: Icons.flash_on, title: 'Speed'),
    const TabItem(icon: Icons.person, title: 'Profile'),
  ];

  final List<Widget> _screens = [
    const ServersScreen(),
    const HomeScreen(),
    const SpeedTestScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
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
        child: BottomBarSalomon(
          items: items,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF9CA3AF),
          colorSelected: Colors.white,
          backgroundSelected: const Color(0xFF00417B),
          borderRadius: BorderRadius.circular(25),
          indexSelected: _currentIndex,

          // paddingVertical: 15,
          // paddingHorizontal: 20,
          titleStyle: GoogleFonts.nunitoSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          iconSize: 24,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          top: 10,
          bottom: 10,
          animated: true,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          enableShadow: false,
          // sizeInside: 48,
          // backgroundSelectedSize: 80,
        ),
      ),
    );
  }
}

// Placeholder screens for other tabs
class ServersScreen extends StatelessWidget {
  const ServersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Servers',
          style: GoogleFonts.nunitoSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF00417B),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Icon(Icons.public, size: 100, color: Color(0xFF00417B)),
      ),
    );
  }
}

class SpeedTestScreen extends StatelessWidget {
  const SpeedTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Speed Test',
          style: GoogleFonts.nunitoSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF00417B),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Icon(Icons.flash_on, size: 100, color: Color(0xFF00417B)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.nunitoSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF00417B),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Icon(Icons.person, size: 100, color: Color(0xFF00417B)),
      ),
    );
  }
}
