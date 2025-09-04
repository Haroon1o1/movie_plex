import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';

Widget buildMovieCard(MovieModel movie) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF1a1a1a),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie poster
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            image: DecorationImage(
              image: AssetImage(movie.images.isNotEmpty ? movie.img : movie.img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                movie.genre.join(', '),
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ],
    ),
  );
}
