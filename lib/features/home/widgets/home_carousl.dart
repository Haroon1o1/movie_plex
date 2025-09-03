import 'package:flutter/material.dart';
import 'package:movie_plex/features/home/widgets/poster_widget.dart';

Widget carouslaView(int index, item, double pageOffset) {
  double value = index.toDouble() - pageOffset;
  value = (value * 0.09).clamp(-1, 1);
  double scale = 1.0 - value.abs();

  bool isCurrent = value.abs() < 0.05;

  return AnimatedScale(
    scale: scale,
    duration: const Duration(milliseconds: 500), // smooth scaling
    curve: Curves.easeInOut,
    child: PosterWidget(
      index: index,
      items: item,
      highlight: isCurrent, // pass highlight state
    ),
  );
}
