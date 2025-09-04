import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendDot(Colors.white, "Available"),
          const SizedBox(width: 12),
          _legendDot(Colors.grey, "Reserved"),
          const SizedBox(width: 12),
          _legendDot(Colors.blue, "Selected"),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(width: 4),
        Text(text, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
