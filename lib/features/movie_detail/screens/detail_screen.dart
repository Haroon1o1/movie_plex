import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/common_widgets/customButton.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/movie_detail/widgets/cast_widget.dart';
import 'package:movie_plex/features/movie_detail/widgets/header.dart';
import 'package:movie_plex/features/movie_detail/widgets/movie_gallery.dart';
import 'package:movie_plex/features/movie_detail/widgets/roundIcons.dart';
import 'package:movie_plex/features/movie_detail/widgets/streamingDates.dart';

class MovieDetailExact extends StatefulWidget {
  final MovieModel movie;

  MovieDetailExact({super.key, required this.movie});

  @override
  State<MovieDetailExact> createState() => _MovieDetailExactState();
}

class _MovieDetailExactState extends State<MovieDetailExact> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: Column(
            children: [
              buildTopBar(context, "Movie Detail"),
              SizedBox(height: 8),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(context, widget.movie),
                      SizedBox(height: 20),

                      _sectionTitle(widget.movie.title, alignCenter: true),
                      SizedBox(height: 16),

                      _sectionTitle("Synopsis"),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _sectionText(widget.movie.description),
                      ),

                      SizedBox(height: 20),

                      // 🔹 TabBar Section
                      TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFfdbf07), // glass-like
                        ),
                        indicatorSize: TabBarIndicatorSize.tab, // makes indicator cover full tab
                        indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ), // 👈 space around indicator
                        dividerColor: AppColors.bg,
                        labelColor: AppColors.bg,
                        unselectedLabelColor: Colors.white70,
                        labelStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        tabs: [
                          Tab(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ), // 👈 text padding inside tab
                              child: Text("Cast"),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              child: Text("Gallery"),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              child: Text("Streaming"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 300, // Fixed height for tab content
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Cast
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CastWidget(widget.movie),
                            ),

                            // Gallery
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Gallery(context, widget.movie),
                            ),

                            // Streaming (Placeholder for now)
                            Center(
                              child: StreamingDatesWidget(
                                dates2D: {
                                  '2025-09-04': ['8:00 AM', '3:00 PM', '6:00 PM'],
                                  '2025-09-05': ['10:00 AM', '2:00 PM'],
                                },
                                dates3D: {
                                  '2025-09-04': ['9:00 AM', '4:00 PM'],
                                  '2025-09-05': ['11:00 AM', '5:00 PM'],
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomButton(
                  hasIcon: true,
                  icon: "assets/icons/ticket.png",
                  height: 50,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFA726), Color.fromARGB(255, 207, 136, 30)],
                  ),
                  textColor: Colors.black87,
                  text: 'Buy Now',
                  press: () {},
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable Top Bar


  /// 🔹 Section Title
  Widget _sectionTitle(String text, {bool alignCenter = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        textAlign: alignCenter ? TextAlign.center : TextAlign.start,
        style: GoogleFonts.poppins(
          color: AppColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 🔹 Section Text
  Widget _sectionText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: AppColors.subtext, height: 1.4, fontSize: 13),
    );
  }
}


  Widget buildTopBar(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          CustomRoundIcon(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.of(context).maybePop(),
          ),
          Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          CustomRoundIcon(icon: Icons.more_horiz_rounded),
        ],
      ),
    );
  }
