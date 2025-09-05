  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';

Widget StatusShowWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.event_seat, size: 18, color: Colors.white),
                  const SizedBox(width: 4),
                  Text("Available", style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
          SizedBox(width: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.event_seat, size: 18, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text("Reserved", style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
          SizedBox(width: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.event_seat, size: 18, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text("Selected", style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
