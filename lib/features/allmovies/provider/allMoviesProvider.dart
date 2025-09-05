import 'package:flutter/material.dart';

class AllMoviesProvider with ChangeNotifier {
  String _searchQuery = '';
  bool _isGridView = false;

  String get searchQuery => _searchQuery;
  bool get isGridView => _isGridView;

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }
}
