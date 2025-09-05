import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/SeatBooking/provider/bookingProvider.dart';
import 'package:movie_plex/features/SeatBooking/widget/MovieImageWidget.dart';
import 'package:movie_plex/features/SeatBooking/widget/bottom_action_bar.dart';
import 'package:movie_plex/features/SeatBooking/widget/circularsitingwidget.dart';
import 'package:movie_plex/features/SeatBooking/widget/date_selector_widget.dart';
import 'package:movie_plex/features/SeatBooking/widget/seatStatusWidget.dart';
import 'package:provider/provider.dart';

class SeatSelectionScreen extends StatefulWidget {
  final MovieModel movie;

  SeatSelectionScreen({super.key, required this.movie});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
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
    final bookingProvider = Provider.of<Bookingprovider>(context);
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
                          child: buildMovieImage(widget.movie.img),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [AppColors.bg, Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SeatLayout(),
                  ],
                ),
              ),

              // Seat status legend
              StatusShowWidget(),

              // Date selection - using dates from movie model
              DateTimeSelectorWidget(
                formats: widget.movie.dates,
                selectedFormat: bookingProvider.selectedFormat,
                selectedDateIndex: bookingProvider.selectedDateIndex,
                selectedTimeIndex: bookingProvider.selectedTimeIndex,
                onFormatSelected: (format) => bookingProvider.setSelectedFormat(format),
                onDateSelected: (index) => bookingProvider.setSelectedDate(index),
                onTimeSelected: (index) => bookingProvider.setSelectedTime(index),
              ),

              const SizedBox(height: 10),

              const SizedBox(height: 20),

              // Bottom action row with price calculation
             BottomActionWidget(context, widget.movie.price),
            ],
          ),
        ),
      ),
    );
  }


}
