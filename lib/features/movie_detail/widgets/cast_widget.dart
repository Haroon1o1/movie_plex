import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';

Widget CastWidget(MovieModel movie) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: movie.actorList.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // 3 items per row
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.8, // adjust for image + text
    ),
    itemBuilder: (context, index) {
      return
         Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    ClipOval(
      child: Image.asset(
        movie.actorList[index].image, // use map with name & image
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceAlt,
            ),
            child: const Icon(Icons.person, color: AppColors.subtext),
          );
        },
      ),
    ),
    const SizedBox(height: 4),
    SizedBox(
      width: 70,
      child: Text(
        movie.actorList[index].name, // actor name
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, color: Colors.white70),
      ),
    ),
  ],
);;
    },
  );
}
