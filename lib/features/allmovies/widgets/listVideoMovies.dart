import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';

Widget buildListMovieCard(MovieModel movie) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1a1a1a),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Movie poster
        Container(
          height: 100,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(image: AssetImage(movie.img), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 10),
        // Movie info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                movie.genre.join(', '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
