import 'package:flutter/material.dart';
import 'package:movie_plex/core/utils/theme_provider.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/home/widgets/home_carousl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);
    final size = MediaQuery.of(context).size;

    // Round current page index
    final currentIndex = homeProvider.currentPage.round();
    final currentItem = Movie_Model.posterList[currentIndex];
    final lastIndex = homeProvider.lastIndex;
    final lastItem = Movie_Model.posterList[lastIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Now Streaming",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? Color(0xFF1a1922)
          : Colors.white,
      body: Stack(
        children: [
          // Background with smooth fade
          Positioned.fill(
            child: Stack(
              children: [
                // Previous image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(lastItem.img), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF1a1922).withAlpha((0.9 * 255).toInt()),
                          const Color(0xFF1a1922).withAlpha(255),
                          const Color(0xFF1a1922).withAlpha(255),
                        ],
                        stops: const [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),

                // Current image fading in
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  onEnd: () => homeProvider.updateLastIndex(currentIndex),
                  child: Container(
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
                            const Color(0xFF1a1922).withAlpha((0.9 * 255).toInt()),
                            const Color(0xFF1a1922).withAlpha(255),
                            const Color(0xFF1a1922).withAlpha(255),
                          ],
                          stops: const [0.0, 0.4, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Carousel
          Center(
            child: SizedBox(
              height: size.height * 0.67,
              width: size.width,
              child: PageView.builder(
                itemCount: Movie_Model.posterList.length,
                physics: const BouncingScrollPhysics(),
                controller: homeProvider.homeCarouslController,
                onPageChanged: homeProvider.updateCurrentPage,
                itemBuilder: (context, index) {
                  final item = Movie_Model.posterList[index];
                  return carouslaView(index, item, homeProvider.currentPage);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
