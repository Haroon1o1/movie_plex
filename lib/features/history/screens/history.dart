import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/features/history/widgets/list_widget.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/movie_detail/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class TicketHistoryScreen extends StatelessWidget {
  const TicketHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Homeprovider>(context).loadMovies();
    final provider = Provider.of<Homeprovider>(context);
    final tickets = provider.tickets; // List<TicketModel>
    final movies = provider.movies; // List<MovieModel>

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Background with gradient (no image here)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.bg.withAlpha((0.9 * 255).toInt()),
                      AppColors.bg,
                      AppColors.bg,
                    ],
                    stops: [0.0, 0.4, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            // Your actual content
            Column(
              children: [
                const SizedBox(height: 8),
                buildTopBar(context, "Ticket History"),
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.separated(
                      itemCount: tickets.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        final movie = movies.firstWhere((m) => m.id == ticket.movieId);

                        return HistoryList(movie, ticket, context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
