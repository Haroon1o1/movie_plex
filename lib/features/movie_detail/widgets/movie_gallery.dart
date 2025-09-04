import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget Gallery(BuildContext context, MovieModel movie) {
  double w = MediaQuery.of(context).size.width;
  double spacing = 8;

  // Sizes for responsiveness
  double largeVideoWidth = w * 0.5;
  double smallColumnWidth = w * 0.35;
  double smallRowWidth = w * 0.3;
  double seeMoreWidth = w * 0.22;

  return Wrap(
    spacing: spacing,
    runSpacing: spacing,
    children: [
      // First row: Video + 2 stacked images
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large Video
          GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(movie.videoLink))) {
                await launchUrl(
                  Uri.parse(movie.videoLink),
                  mode: LaunchMode.externalApplication,
                );
              } else {
                log('Could not launch ${Uri.parse(movie.videoLink)}');
              }
            },
            child: Container(
              width: largeVideoWidth,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(movie.images[1]), // video thumbnail
                  fit: BoxFit.cover,
                ),
              ),
              child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
            ),
          ),
          const SizedBox(width: 8),
          // Column with 2 images stacked
          Column(
            children: [
              Container(
                width: smallColumnWidth,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                  image: DecorationImage(image: AssetImage(movie.images[1]), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: smallColumnWidth,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                  image: DecorationImage(image: AssetImage(movie.images[2]), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ],
      ),

      // Second row: 2 images + See More
      Row(
        children: [
          Container(
            width: smallRowWidth,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
              image: DecorationImage(image: AssetImage(movie.images[3]), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: smallRowWidth,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
              image: DecorationImage(image: AssetImage(movie.images[4]), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: seeMoreWidth,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.3),
              border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "+22",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
