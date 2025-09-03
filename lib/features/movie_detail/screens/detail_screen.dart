import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/common_widgets/customButton.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/movie_detail/providers/detailProvider.dart';
import 'package:movie_plex/features/movie_detail/widgets/StatCard.dart';
import 'package:movie_plex/features/movie_detail/widgets/movie_gallery.dart';
import 'package:movie_plex/features/movie_detail/widgets/roundIcons.dart';
import 'package:provider/provider.dart';

class MovieDetailExact extends StatefulWidget {
  final Movie_Model movie;

  const MovieDetailExact({super.key, required this.movie});

  @override
  State<MovieDetailExact> createState() => _MovieDetailExactState();
}

class _MovieDetailExactState extends State<MovieDetailExact> {
  @override
  void initState() {
    super.initState();
    // Start listening to sensors when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final sensorProvider = Provider.of<SensorProvider>(context, listen: false);
      // sensorProvider.startListening();
    });
  }

  @override
  void dispose() {
    // Stop listening to sensors when the widget is disposed
    // final sensorProvider = Provider.of<SensorProvider>(context, listen: false);
    // sensorProvider.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final sensorProvider = Provider.of<SensorProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          top: true,
          bottom: true,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0x191F0A00), Color(0x00000000)],
              ),
            ),
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      CustomRoundIcon(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Movie Detail',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const CustomRoundIcon(icon: Icons.more_horiz_rounded),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster + Stats
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Poster - fixed size
                            SizedBox(
                              width: w * 0.54,
                              height: h * 0.4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 24,
                                      offset: Offset(0, 16),
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Hero(
                                  tag: widget.movie.img,
                                  child: Image.asset(
                                    widget.movie.img,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.surfaceAlt,
                                        child: const Icon(
                                          Icons.movie_rounded,
                                          color: AppColors.subtext,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16), // fixed spacing
                            // Stat Cards Column - takes max available width
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch, // make cards fill width
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StatCard(
                                    icon: "assets/icons/imdb-icon.png",
                                    title: 'Ratings',
                                    value: widget.movie.rating,
                                  ),
                                  const SizedBox(height: 12),
                                  StatCard(
                                    icon: "assets/icons/video-icon.png",
                                    title: 'Genre',
                                    value: '${widget.movie.genre[0]}',
                                  ),
                                  const SizedBox(height: 12),
                                  StatCard(
                                    icon: "assets/icons/watch.png",
                                    title: 'Duration',
                                    value: '${widget.movie.duration} ',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        Center(
                          child: Text(
                            widget.movie.title,
                            style: GoogleFonts.poppins(
                              color: AppColors.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          'Synopsis',
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          widget.movie.description,
                          style: GoogleFonts.poppins(
                            color: AppColors.subtext,
                            height: 1.3,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Actors section
                        Text(
                          'Cast',
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.movie.actorList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipOval(
                                  child: Image.asset(
                                    widget.movie.actorList[index],
                                    width: 70, // make sure width & height are equal
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60,
                                        height: 60,
                                        color: AppColors.surfaceAlt,
                                        child: const Icon(Icons.person, color: AppColors.subtext),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Actors section
                        Text(
                          'Gallery',
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Gallery(context, widget.movie),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // Bottom CTA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    hasIcon: true,
                    icon: "assets/icons/ticket.png",
                    height: 50,
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFFFFA726), // base amber orange
                        Color.fromARGB(255, 173, 93, 13), // deeper, muted burnt orange
                      ],
                    ),
                    textColor: Color.fromARGB(255, 43, 43, 43),
                    text: 'Buy Now',
                    press: () {},
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
