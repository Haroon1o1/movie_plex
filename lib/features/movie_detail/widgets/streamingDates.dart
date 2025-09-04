import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_plex/core/constants/app_colors.dart';

class StreamingDatesWidget extends StatelessWidget {
  final Map<String, List<String>> dates2D;
  final Map<String, List<String>> dates3D;

  StreamingDatesWidget({super.key, required this.dates2D, required this.dates3D});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2D Section
          Text(
            "2D Showtimes",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...dates2D.entries.map((entry) => DateTile(date: entry.key, times: entry.value)),

          SizedBox(height: 20),

          // 3D Section
          Text(
            "3D Showtimes",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...dates3D.entries.map((entry) => DateTile(date: entry.key, times: entry.value)),
        ],
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  final String date;
  final List<String> times;

  DateTile({super.key, required this.date, required this.times});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMM').format(DateTime.parse(date)); // e.g., 4 Sep
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              formattedDate,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: times
                    .map(
                      (time) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFfdbf07),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          time,
                          style: GoogleFonts.poppins(color: AppColors.bg, fontSize: 12),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
