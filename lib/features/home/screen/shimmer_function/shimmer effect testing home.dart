import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/utils/theme_provider.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/home/widgets/home_carousl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomePage extends StatelessWidget {
  const ShimmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);
    final size = MediaQuery.of(context).size;

    // Round current page index
    final currentIndex = homeProvider.currentItem.round();
    final currentItem = Movie_Model.posterList[currentIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Now Streaming", style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
      ),
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? Color(0xFF1a1922)
          : Colors.white,
      body: Stack(
        children: [
          // Background with smooth fade

          // Carousel
          Center(
            child: SizedBox(
              height: size.height * 0.67,
              width: size.width,
              child: PageView.builder(
                itemCount: Movie_Model.posterList.length,
                physics: const BouncingScrollPhysics(),
                controller: homeProvider.homeCarouslController,
                onPageChanged: homeProvider.updateCurrentItem,
                itemBuilder: (context, index) {
                  final item = Movie_Model.posterList[index];
                  return shimmerCarosal(index, item, homeProvider.currentItem);
                },
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.05, // stick 20px from bottom
            left: 0,
            right: 0,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

Widget shimmerCarosal(int index, item, double pageOffset) {
  double value = index.toDouble() - pageOffset;
  value = (value * 0.09).clamp(-1, 1);
  double scale = 1.0 - value.abs();

  bool isCurrent = value.abs() < 0.05;

  return AnimatedScale(
    scale: scale,
    duration: const Duration(milliseconds: 500), // smooth scaling
    curve: Curves.easeInOut,
    child: ShimmerPosterWidget(),
  );
}

class ShimmerPosterWidget extends StatelessWidget {
  const ShimmerPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3C3C3C),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image placeholder
          Container(
            height: h * 0.50,
            width: w * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.orange.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(3, 3),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.03),

          // Title placeholder (increased height)
          Container(
            height: 42,
            width: w * 0.6,

            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),

          // Genre placeholder (increased height)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: List.generate(
              3,
              (index) => Container(
                height: 20,
                width: w * 0.18,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
