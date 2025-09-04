import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/features/allmovies/screen/allmovies.dart';
import 'package:movie_plex/features/history/screens/history.dart';
import 'package:movie_plex/features/home/screen/homeScreenWrapper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomePageWrapper(), MovieListScreen(), TicketHistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true, // 👈 important so nav bar floats over body background
        backgroundColor: Colors.transparent, // 👈 transparent scaffold
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.bg, // 👈 semi-transparent for glass look
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(icon: "assets/icons/video-icon.png", label: "Trending", index: 0),

              navItem(icon: "assets/icons/video-icon.png", label: "Movies", index: 1),
              navItem(icon: "assets/icons/watch.png", label: "Tickets", index: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem({required String icon, required String label, required int index}) {
    final isActive = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque, // ensures entire area is tappable
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8), // extra tap space vertically
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(width: 16, icon, color: isActive ? AppColors.primary : Colors.grey[400]),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: isActive ? AppColors.primary : Colors.grey[400],
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
