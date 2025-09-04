import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomActionBar extends StatelessWidget {
  final int selectedSeatsCount;
  final double price;
  final VoidCallback onGetTicket;

  const BottomActionBar({
    super.key,
    required this.selectedSeatsCount,
    required this.price,
    required this.onGetTicket,
  });

  @override
  Widget build(BuildContext context) {
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
                    "x$selectedSeatsCount",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Total: \$${selectedSeatsCount * price}",
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
            onPressed: onGetTicket,
            child: Text(
              "Get a ticket",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
