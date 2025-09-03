import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:movie_plex/core/utils/theme_provider.dart';

class InfoItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const InfoItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Column(
      children: [
        Icon(
          icon,
          color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
