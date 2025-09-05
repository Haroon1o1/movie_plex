import 'package:flutter/material.dart';

 Widget buildMovieImage(String img) {


    // Check if the image path is a network URL (starts with http)
    if (img.startsWith('http')) {
      return Image.network(
        img,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      // Assume it's a local asset
      return Image.asset(
        img,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
  }

   Widget _buildPlaceholder() {
    return Container(
      height: 200,
      color: Colors.grey.shade800,
      child: const Icon(Icons.movie, color: Colors.white, size: 60),
    );
  }
