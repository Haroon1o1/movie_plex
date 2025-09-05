import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/data/models/ticket_model.dart';
import 'package:movie_plex/features/tickets/screens/ticket.dart';

Widget HistoryList(MovieModel movie, TicketModel ticket, BuildContext context) {
  final now = DateTime.now();
  final isExpired = ticket.movie_time.isBefore(now);
  final isUnpaidExpired = !ticket.paid && isExpired; // ✅ check unpaid + expired
  final dateFormat = DateFormat('MMM dd, yyyy');
  final timeFormat = DateFormat('hh:mm a');

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicketScreen(ticket: ticket)),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isExpired ? Colors.orange : (ticket.paid ? Colors.green : Colors.red),
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie poster
          Container(
            width: 60,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: movie.img.isNotEmpty
                  ? DecorationImage(image: AssetImage(movie.img), fit: BoxFit.cover)
                  : null,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(width: 16),

          // Info column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min, // ensure column takes minimal height
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isExpired
                                ? Colors.orange
                                : (ticket.paid ? Colors.green : Colors.red),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isExpired ? "EXPIRED" : (ticket.paid ? "PAID" : "UNPAID"),
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Delete icon if unpaid and expired
                        if (isUnpaidExpired)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.delete, color: Colors.red, size: 16),
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Movie time row
                Text(
                  dateFormat.format(ticket.movie_time),
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),

                const SizedBox(height: 6),

                // Last watch + seat row
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      timeFormat.format(ticket.movie_time),
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.confirmation_num, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      ticket.seatNumber,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
