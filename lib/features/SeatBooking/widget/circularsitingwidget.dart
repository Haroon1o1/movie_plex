import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:movie_plex/features/SeatBooking/provider/bookingProvider.dart';

class SeatLayout extends StatelessWidget {
  final List<int> seatsPerRow = [
    2, // top row
    3, // 2nd row
    4, // middle rows
    4,
    4,
    3,
    2, // bottom row
  ];

  final List<int> reservedSeats = [3, 4, 12, 18, 20, 25, 45, 50, 65, 72];

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<Bookingprovider>(context);

    return Positioned(
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
                            colors: [Color.fromARGB(255, 29, 28, 19), Colors.black],
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
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(seatsPerRow.length, (rowIndex) {
        int seatCount = seatsPerRow[rowIndex];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // left side seats
              ...List.generate(seatCount, (i) {
                int seatNumber = rowIndex * 10 + i; // unique id per seat

                bool isReserved = reservedSeats.contains(seatNumber);
                bool isSelected = bookingProvider.selectedSeats.contains(seatNumber);

                Color color = isReserved
                    ? Colors.grey.shade700
                    : (isSelected ? AppColors.primary : Colors.white);

                return GestureDetector(
                  onTap: isReserved
                      ? null
                      : () {
                          if (isSelected) {
                            bookingProvider.removeSeat(seatNumber);
                          } else {
                            bookingProvider.addSeat(seatNumber);
                          }
                        },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.event_seat,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.065,
                    ),
                  ),
                );
              }),
              const SizedBox(width: 20), // middle aisle gap
              // right side seats
              ...List.generate(seatCount, (i) {
                int seatNumber = rowIndex * 10 + seatCount + i;

                bool isReserved = reservedSeats.contains(seatNumber);
                bool isSelected = bookingProvider.selectedSeats.contains(seatNumber);

                Color color = isReserved
                    ? Colors.grey.shade700
                    : (isSelected ? AppColors.primary : Colors.white);

                return GestureDetector(
                  onTap: isReserved
                      ? null
                      : () {
                          if (isSelected) {
                            bookingProvider.removeSeat(seatNumber);
                          } else {
                            bookingProvider.addSeat(seatNumber);
                          }
                        },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.event_seat,
                      color: color,
                      size: MediaQuery.of(context).size.width * 0.065,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    ) ),
                        ),
                      ),
                    );
  }
}
