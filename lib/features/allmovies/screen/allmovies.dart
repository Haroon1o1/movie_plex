import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_plex/features/allmovies/provider/allMoviesProvider.dart';
import 'package:movie_plex/features/allmovies/widgets/gridViewMovies.dart';
import 'package:movie_plex/features/allmovies/widgets/listVideoMovies.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/movie_detail/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allMoviesProvider = Provider.of<AllMoviesProvider>(context);
    final homeProvider = Provider.of<Homeprovider>(context);

    // Filter movies based on search query
    final filteredMovies = homeProvider.movies
        .where(
          (movie) =>
              movie.title.toLowerCase().contains(allMoviesProvider.searchQuery.toLowerCase()),
        )
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
            icon: Icon(allMoviesProvider.isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => allMoviesProvider.toggleView(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => allMoviesProvider.setSearchQuery(value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF1a1a1a),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Movie list/grid
          Expanded(
            child: allMoviesProvider.isGridView
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
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
