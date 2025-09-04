import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';

class SeatSelectionScreen extends StatefulWidget {
  final MovieModel movie;

  SeatSelectionScreen({super.key, required this.movie});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<int> selectedSeats = [7, 8, 9]; // initially selected seats
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  // Extract dates and times from the movie model
  List<String> get dates {
    if (widget.movie.dates.isEmpty) return ["No dates available"];

    // Get all available dates (keys from the first cinema)
    final cinemaKey = widget.movie.dates.keys.first;
    return widget.movie.dates[cinemaKey]?.keys.toList() ?? ["No dates available"];
  }

  List<String> get times {
    if (widget.movie.dates.isEmpty) return ["No times available"];

    // Get times for the selected date
    final cinemaKey = widget.movie.dates.keys.first;
    final selectedDate = dates[selectedDateIndex];

    return widget.movie.dates[cinemaKey]?[selectedDate] ?? ["No times available"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(200),
                            topRight: Radius.circular(200),
                          ),
                          child: _buildMovieImage(),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left:
                          (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width * 0.95) /
                          2,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromARGB(255, 19, 20, 29), Colors.black],
                            stops: [0.0, 0.8],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 3,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.black, width: 6),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Row 1 (4 seats - 2 on each side)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSeat(0), // Left side
                                    _buildSeat(1),
                                    SizedBox(width: 40), // Central aisle gap
                                    _buildSeat(2), // Right side
                                    _buildSeat(3),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Row 2 (4 seats - 2 on each side)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSeat(4),
                                    _buildSeat(5),
                                    SizedBox(width: 40),
                                    _buildSeat(6),
                                    _buildSeat(7),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Row 3 (6 seats - 3 on each side)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSeat(8),
                                    _buildSeat(9),
                                    _buildSeat(10),
                                    SizedBox(width: 40),
                                    _buildSeat(11),
                                    _buildSeat(12),
                                    _buildSeat(13),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Row 4 (6 seats - 3 on each side)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSeat(14),
                                    _buildSeat(15),
                                    _buildSeat(16),
                                    SizedBox(width: 40),
                                    _buildSeat(17),
                                    _buildSeat(18),
                                    _buildSeat(19),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Seat status legend
              Padding(
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
              ),

              // Date selection - using dates from movie model
              _sectionTitle("Select Date"),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedDateIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                          selectedTimeIndex = 0; // Reset time selection when date changes
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        height: 60, // Adjusted height
                        // width: MediaQuery.of(context).size.width * 0.28, // Adjusted width
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
                          (dates[index]),
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
              const SizedBox(height: 10),
              _sectionTitle("Select Time"),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedTimeIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTimeIndex = index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        height:
                            MediaQuery.of(context).size.height *
                            0.06, // Slightly shorter than date container
                        width:
                            MediaQuery.of(context).size.width *
                            0.32, // Slightly wider for time text
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

              const SizedBox(height: 20),

              // Bottom action row with price calculation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.confirmation_number, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              "x${selectedSeats.length}",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total: \$${selectedSeats.length * widget.movie.price}",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Get a ticket",
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieImage() {
    final String imagePath = widget.movie.img;

    // Check if the image path is a network URL (starts with http)
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      // Assume it's a local asset
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 200,
      color: Colors.grey.shade800,
      child: const Icon(Icons.movie, color: Colors.white, size: 60),
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 20, bottom: 8, top: 12),
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

  Widget _buildSeat(int index) {
    bool isReserved = [3, 4, 12, 18, 20, 25, 45, 50, 65, 72].contains(index);
    bool isSelected = selectedSeats.contains(index);

    Color color = isReserved
        ? Colors.grey.shade700
        : (isSelected ? Color(0xFF2A34F9).withOpacity(0.2) : Colors.white);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: GestureDetector(
        onTap: isReserved
            ? null
            : () {
                setState(() {
                  if (isSelected) {
                    selectedSeats.remove(index);
                  } else {
                    selectedSeats.add(index);
                  }
                });
              },
        child: Icon(Icons.event_seat, color: color, size: 26),
      ),
    );
  }
}
