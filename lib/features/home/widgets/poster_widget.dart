import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/movie_detail/screens/detail_screen.dart';

class PosterWidget extends StatelessWidget {
  final MovieModel items;
  final bool highlight;
  final int index;

  const PosterWidget({
    super.key,
    required this.index,
    required this.items,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetailExact(movie: items)),
            );
          },
          child: Hero(
            tag: items.img,
            child: Container(
              height: h * 0.50,
              width: w * 0.7,
              decoration: BoxDecoration(
                boxShadow: highlight
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(3, 3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: AssetImage(items.img), fit: BoxFit.fill),
              ),
            ),
          ),
        ),

        SizedBox(height: h * 0.03),

        // Title Fade Animation
        AnimatedOpacity(
          opacity: highlight ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Text(
            items.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 2,
              color: AppColors.primary,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Genre Fade Animation
        AnimatedOpacity(
          opacity: highlight ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 2,
            children: [
              Text(
                'Genre: ',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              ...items.genre.asMap().entries.map((entry) {
                int idx = entry.key;
                String g = entry.value;
                return Text(
                  idx < items.genre.length - 1 ? "$g," : g,
                  style: GoogleFonts.poppins(fontSize: 14),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
