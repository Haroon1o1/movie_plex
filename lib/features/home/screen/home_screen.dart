import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/utils/theme_provider.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/home/widgets/home_carousl.dart';
import 'package:movie_plex/testing%20stuff/shimmer%20effect%20testing%20home.dart';
import 'package:provider/provider.dart';

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  @override
  void initState() {
    super.initState();

    // Delay shimmer for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<Homeprovider>(context, listen: false).setLoading(false);
          // Provider.of<Homeprovider>(context, listen: false).setAppOpenedFirstTime(false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);

    return homeProvider.isLoading && homeProvider.appOpenedFirstTime
        ? const ShimmerHomePage()
        : const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);
    homeProvider.setAppOpenedFirstTime(false);
    final size = MediaQuery.of(context).size;

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
          ? const Color(0xFF1a1922)
          : Colors.white,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
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
                        const Color(0xFF1a1922).withAlpha((0.9 * 255).toInt()),
                        const Color(0xFF1a1922),
                        const Color(0xFF1a1922),
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
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
                onPageChanged: homeProvider.updateCurrentItem,
                itemBuilder: (context, index) {
                  final item = Movie_Model.posterList[index];
                  return carouslaView(index, item, homeProvider.currentItem);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
