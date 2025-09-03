import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/movie_detail/Provider/detailProvider.dart';
import 'package:movie_plex/features/movie_detail/widgets/StatCard.dart';
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
      final sensorProvider = Provider.of<SensorProvider>(context, listen: false);
      sensorProvider.startListening();
    });
  }

  @override
  void dispose() {
    // Stop listening to sensors when the widget is disposed
    final sensorProvider = Provider.of<SensorProvider>(context, listen: false);
    sensorProvider.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                            letterSpacing: 0.2,
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
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster + Stats
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Poster with parallax effect
                            Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001) // Perspective
                                ..rotateX(sensorProvider.y)
                                ..rotateY(-sensorProvider.x),
                              alignment: FractionalOffset.center,
                              child: Container(
                                width: w * 0.54,
                                height: w * 0.72,
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
                            const SizedBox(width: 14),
                            // Right Stat Cards
                            Expanded(
                              child: Column(
                                children: [
                                  StatCard(
                                    icon: Icons.theaters_rounded,
                                    title: 'Genre',
                                    value: widget.movie.genre.join(', '),
                                  ),
                                  const SizedBox(height: 12),
                                  StatCard(
                                    icon: Icons.attach_money_rounded,
                                    title: 'Price',
                                    value: '\$${widget.movie.price}',
                                  ),
                                  const SizedBox(height: 12),
                                  StatCard(
                                    icon: Icons.people_rounded,
                                    title: 'Cast',
                                    value: '${widget.movie.actorList.length} actors',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        Text(
                          widget.movie.title,
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          'Synopsis',
                          style: GoogleFonts.poppins(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          widget.movie.description,
                          style: GoogleFonts.poppins(
                            color: AppColors.subtext,
                            height: 1.55,
                            fontSize: 13.8,
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
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.movie.actorList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.line),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    widget.movie.actorList[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
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

                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),

                // Bottom CTA
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black87, blurRadius: 24, offset: Offset(0, -8)),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
                  child: SizedBox(
                    width: w * 0.6,
                    height: 56,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.pill,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(color: Color(0x66FFB43A), blurRadius: 18, offset: Offset(0, 8)),
                        ],
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Get Reservation',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
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
