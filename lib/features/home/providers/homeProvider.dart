import 'package:flutter/material.dart';

class Homeprovider with ChangeNotifier {
  // Page controller for the carousel
  final PageController _homeCarouslController = PageController(
    initialPage: 0,
    viewportFraction: 0.74,
  );
  PageController get homeCarouslController => _homeCarouslController;

  // Current page (double for smooth animation)
  double _currentPage = 0.0;
  double get currentPage => _currentPage;

  // Last index (for background fade)
  int _lastIndex = 0;
  int get lastIndex => _lastIndex;

  // Update current page
  void updateCurrentPage(int index) {
    _currentPage = index.toDouble();
    notifyListeners();
  }

  // Update last index after fade completes
  void updateLastIndex(int index) {
    _lastIndex = index;
    notifyListeners();
  }

  // Optional: attach listener to PageController to track current page continuously
  void addPageListener() {
    _homeCarouslController.addListener(() {
      _currentPage = _homeCarouslController.page ?? 0.0;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _homeCarouslController.dispose();
    super.dispose();
  }
}
