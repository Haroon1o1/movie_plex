import 'package:flutter/material.dart';

class Bookingprovider with ChangeNotifier {
  // --- Seats ---
  final List<int> _selectedSeats = [];
  List<int> get selectedSeats => _selectedSeats;

  // --- Format (2D / 3D) ---
  String _selectedFormat = "2D";
  String get selectedFormat => _selectedFormat;

  // --- Date ---
  int _selectedDateIndex = 0;
  int get selectedDateIndex => _selectedDateIndex;

  // --- Time ---
  int _selectedTimeIndex = 0;
  int get selectedTimeIndex => _selectedTimeIndex;

  // --- Seats Functions ---
  void addSeat(int seat) {
    if (!_selectedSeats.contains(seat)) {
      _selectedSeats.add(seat);
      notifyListeners();
    }
  }

  void removeSeat(int seat) {
    _selectedSeats.remove(seat);
    notifyListeners();
  }

  void clearSeats() {
    _selectedSeats.clear();
    notifyListeners();
  }

  // --- Format Functions ---
  void setSelectedFormat(String format) {
    _selectedFormat = format;
    _selectedDateIndex = 0; // reset when format changes
    _selectedTimeIndex = 0; // reset when format changes
    notifyListeners();
  }

  // --- Date Functions ---
  void setSelectedDate(int index) {
    _selectedDateIndex = index;
    _selectedTimeIndex = 0; // reset when date changes
    notifyListeners();
  }

  // --- Time Functions ---
  void setSelectedTime(int index) {
    _selectedTimeIndex = index;
    notifyListeners();
  }
}
