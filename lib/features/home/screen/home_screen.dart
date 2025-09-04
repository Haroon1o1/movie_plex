import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/home/widgets/home_carousl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);
    final size = MediaQuery.of(context).size;

    final currentIndex = homeProvider.currentItem.round();
    final currentItem = homeProvider.movies[currentIndex];

    return Scaffold(
      backgroundColor: AppColors.bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Now Streaming",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: Container(
                key: ValueKey(currentItem.img),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(currentItem.img), fit: BoxFit.cover),
                ),
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
            ),
          ),

          // Carousel
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.1),
              child: SizedBox(
                height: size.height * 0.67,
                width: size.width,
                child: PageView.builder(
                  itemCount: homeProvider.movies.length,
                  physics: BouncingScrollPhysics(),
                  controller: homeProvider.homeCarouslController,
                  onPageChanged: homeProvider.updateCurrentItem,
                  itemBuilder: (context, index) {
                    final item = homeProvider.movies[index];
                    return carouslaView(index, item, homeProvider.currentItem);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
