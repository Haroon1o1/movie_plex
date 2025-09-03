import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _homeCarouslController.dispose();
    super.dispose();
  }
}
