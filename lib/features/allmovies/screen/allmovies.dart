import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/core/constants/app_colors.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/features/allmovies/widgets/gridViewMovies.dart';
import 'package:movie_plex/features/allmovies/widgets/listVideoMovies.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/movie_detail/screens/detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MovieListScreen extends StatefulWidget {
  MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String searchQuery = '';
  bool isGridView = false; // toggle view

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Homeprovider>(context);

    // Filter movies based on search query
    final filteredMovies = provider.movies
        .where((movie) => movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Movies",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Color(0xFF1a1a1a),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Movie list/grid
          Expanded(
            child: isGridView
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MovieDetailExact(movie: movie)),
                          );
                        },
                        child: buildMovieCard(movie),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: buildListMovieCard(movie),
                      );
                    },
                  ),
          ),

          SizedBox(height: 80),
        ],
      ),
    );
  }
}
