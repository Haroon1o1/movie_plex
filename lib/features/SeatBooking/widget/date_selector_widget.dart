import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';

class DateTimeSelectorWidget extends StatelessWidget {
  final Map<String, Map<String, List<String>>> formats;
  final String selectedFormat;
  final int selectedDateIndex;
  final int selectedTimeIndex;
  final Function(String) onFormatSelected;
  final Function(int) onDateSelected;
  final Function(int) onTimeSelected;

  const DateTimeSelectorWidget({
    super.key,
    required this.formats,
    required this.selectedFormat,
    required this.selectedDateIndex,
    required this.selectedTimeIndex,
    required this.onFormatSelected,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final dates = formats[selectedFormat]?.keys.toList() ?? [];
    final times = dates.isNotEmpty
        ? (formats[selectedFormat]?[dates[selectedDateIndex]] ?? [])
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Select Format"),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: formats.keys.map((format) {
              bool isSelected = selectedFormat == format;
              return GestureDetector(
                onTap: () => onFormatSelected(format),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.bg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    format,
                    style: GoogleFonts.poppins(
                      color: isSelected ? AppColors.bg : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        _sectionTitle("Select Date"),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedDateIndex == index;

              // Convert "YYYY-MM-DD" to day and short month
              final date = DateTime.parse(dates[index]);
              final day = date.day.toString().padLeft(2, '0'); // e.g., 04
              final month = _shortMonth(date.month); // e.g., Sep

              return GestureDetector(
                onTap: () => onDateSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.bg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        month,
                        style: GoogleFonts.poppins(
                          color: isSelected ? AppColors.bg : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        day,
                        style: GoogleFonts.poppins(
                          color: isSelected ? AppColors.bg : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        _sectionTitle("Select Time"),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedTimeIndex == index;
              return GestureDetector(
                onTap: () => onTimeSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.bg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    times[index],
                    style: GoogleFonts.poppins(
                      color: isSelected ? AppColors.bg : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}

String _shortMonth(int month) {
  const months = [
    '', // Placeholder for 0-index
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return months[month];
}
