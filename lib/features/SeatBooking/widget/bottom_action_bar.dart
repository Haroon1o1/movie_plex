import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/common_widgets/customButton.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/features/SeatBooking/provider/bookingProvider.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/tickets/screens/ticket.dart';
import 'package:provider/provider.dart';

Widget BottomActionWidget(BuildContext context, int price) {

  return Container(
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
                  "x ${Provider.of<Bookingprovider>(context).selectedSeats.length}",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Total: PKR ${Provider.of<Bookingprovider>(context).selectedSeats.length * price}",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          width: 150,
          height: 40,
          child: CustomButton(
            hasIcon: false,
            height: 40,
            textColor: AppColors.bg,
            text: 'Buy your tickets',
            color: AppColors.primary,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TicketScreen(ticket: Provider.of<Homeprovider>(context).tickets[0]),
                ),
              );
            },
            size: 15,
          ),
        ),
      ],
    ),
  );
}
