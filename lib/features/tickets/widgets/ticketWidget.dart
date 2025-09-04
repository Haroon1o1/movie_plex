import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/data/models/ticket_model.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/tickets/widgets/divider.dart';
import 'package:movie_plex/features/tickets/widgets/ticket-info-vertical.dart';
import 'package:movie_plex/features/tickets/widgets/ticketClipper.dart';
import 'package:provider/provider.dart';

class TicketWidget extends StatelessWidget {
  TicketModel ticket;
  TicketWidget({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Homeprovider>(context);

    final movie = provider.movies.firstWhere((m) => m.id == ticket.movieId);

    final size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: double.infinity,
        height: size.height * 0.6,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 27, 28, 34),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: _buildVerticalContent(context, movie, ticket),
      ),
    );
  }

  Widget _buildVerticalContent(BuildContext context, MovieModel movie, TicketModel ticket) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    final isExpired = ticket.movie_time.isBefore(now);
    final statusText = isExpired ? 'EXPIRED' : (ticket.paid ? 'PAID' : 'UNPAID');
    final statusColor = isExpired ? Colors.orange : (ticket.paid ? Colors.green : Colors.red);

    return Stack(
      children: [
        // Main ticket background
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            color: Color(0xFF1b1c22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Movie poster
                Container(
                  height: size.height * 0.24,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(movie.images[1]), fit: BoxFit.cover),
                  ),
                ),
                // Ticket details
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 8, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.title,
                              style: GoogleFonts.poppins(
                                color: Color(0xFFfdbf07),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ticket.userName,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '${movie.duration} | ${movie.genre[0]}',
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 16),
                      DottedDivider(height: 1.5, dashWidth: 6, dashSpacing: 4),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TicketInfo(
                              title: 'Date',
                              value: "${ticket.createdDate.toLocal().toString().split(' ')[0]}",
                            ),
                            TicketInfo(
                              title: 'Time',
                              value:
                                  "${ticket.createdDate.toLocal().hour}:${ticket.createdDate.toLocal().minute.toString().padLeft(2, '0')}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TicketInfo(title: 'Theater', value: 'Cinemax'),
                            TicketInfo(title: 'Seat', value: ticket.seatNumber),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      DottedDivider(height: 1.5, dashWidth: 6, dashSpacing: 4),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ticket.price.toString() + " PKR",
                              style: GoogleFonts.poppins(
                                color: Color(0xFFfdbf07),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Status stamp overlay
        Positioned(
          top: size.height * 0.02,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusText,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
