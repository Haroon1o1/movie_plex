import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSelectorWidget extends StatelessWidget {
  final List<String> times;
  final int selectedIndex;
  final Function(int) onTimeSelected;

  const TimeSelectorWidget({
    super.key,
    required this.times,
    required this.selectedIndex,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Select Time"),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onTimeSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF99CCF6).withOpacity(0.2)
                        : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF99CCF6).withOpacity(0.6)
                          : Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    times[index],
                    style: GoogleFonts.poppins(
                      color: isSelected ? const Color(0xFF99CCF6) : Colors.white,
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
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
