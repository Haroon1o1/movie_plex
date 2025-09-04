import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_plex/data/models/movie_model.dart';
import 'package:movie_plex/data/models/ticket_model.dart';

class Homeprovider with ChangeNotifier {
  // Page controller for the carousel
  final PageController _homeCarouslController = PageController(
    initialPage: 0,
    viewportFraction: 0.74,
  );
  PageController get homeCarouslController => _homeCarouslController;

  // Current item (double for smooth animation)
  double _currentItem = 0.0;
  double get currentItem => _currentItem;

  // to control shimmer effect
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // shimmer will show first time only or if data is not fetched
  bool appOpenedFirstTime = true;
  bool get isAppOpenedFirstTime => appOpenedFirstTime;

  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  List<TicketModel> _tickets = [];
  List<TicketModel> get tickets => _tickets;



  void setAppOpenedFirstTime(bool value) {
    appOpenedFirstTime = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Update current page
  void updateCurrentItem(int index) {
    _currentItem = index.toDouble();
    notifyListeners();
  }

  // Optional: attach listener to PageController to track current page continuously
  void addPageListener() {
    _homeCarouslController.addListener(() {
      _currentItem = _homeCarouslController.page ?? 0.0;
      notifyListeners();
    });
  }

Future<void> loadMovies() async {
  final String movieResponse = await rootBundle.loadString('assets/json/movies.json');
  final String ticketResponse = await rootBundle.loadString('assets/json/history.json');
  final Map<String, dynamic> movieData = json.decode(movieResponse);
  final Map<String, dynamic> ticketData = json.decode(ticketResponse);
  final List<dynamic> moviesJson = movieData['movies'] ?? [];
  final List<dynamic> ticketJson = ticketData['history'] ?? [];
  _movies = moviesJson.map((json) => MovieModel.fromJson(json)).toList();
  _tickets = ticketJson.map((json) => TicketModel.fromJson(json)).toList();

  notifyListeners();
}



  @override
  void dispose() {
    _homeCarouslController.dispose();
    super.dispose();
  }
}
