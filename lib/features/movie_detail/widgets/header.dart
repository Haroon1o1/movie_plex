import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/movie_detail/widgets/StatCard.dart';

Widget Header(BuildContext context, MovieModel movie) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Poster - fixed size
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.54,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 24, offset: Offset(0, 16)),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Hero(
            tag: movie.img,
            child: Image.asset(
              movie.img,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.surfaceAlt,
                  child: const Icon(Icons.movie_rounded, color: AppColors.subtext),
                );
              },
            ),
          ),
        ),
      ),

      const SizedBox(width: 16), // fixed spacing
      // Stat Cards Column - takes max available width
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // make cards fill width
          mainAxisSize: MainAxisSize.min,
          children: [
            StatCard(
              icon: "assets/icons/imdb-icon.png",
              title: 'Ratings',
              value: movie.rating,
            ),
            const SizedBox(height: 12),
            StatCard(
              icon: "assets/icons/video-icon.png",
              title: 'Genre',
              value: '$movie.genre[0]}',
            ),
            const SizedBox(height: 12),
            StatCard(
              icon: "assets/icons/watch.png",
              title: 'Duration',
              value: '$movie.duration} ',
            ),
          ],
        ),
      ),
    ],
  );
}
