import 'package:flutter/material.dart';

class SeatLayoutWidget extends StatelessWidget {
  final List<int> selectedSeats;
  final Function(int) onSeatSelected;

  const SeatLayoutWidget({
    super.key,
    required this.selectedSeats,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 19, 20, 29), Colors.black],
          stops: [0.0, 0.8],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.black, width: 6),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row 1 (4 seats - 2 on each side)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSeat(0),
                  _buildSeat(1),
                  const SizedBox(width: 40),
                  _buildSeat(2),
                  _buildSeat(3),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2 (4 seats - 2 on each side)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSeat(4),
                  _buildSeat(5),
                  const SizedBox(width: 40),
                  _buildSeat(6),
                  _buildSeat(7),
                ],
              ),
              const SizedBox(height: 12),

              // Row 3 (6 seats - 3 on each side)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSeat(8),
                  _buildSeat(9),
                  _buildSeat(10),
                  const SizedBox(width: 40),
                  _buildSeat(11),
                  _buildSeat(12),
                  _buildSeat(13),
                ],
              ),
              const SizedBox(height: 12),

              // Row 4 (6 seats - 3 on each side)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSeat(14),
                  _buildSeat(15),
                  _buildSeat(16),
                  const SizedBox(width: 40),
                  _buildSeat(17),
                  _buildSeat(18),
                  _buildSeat(19),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeat(int index) {
    bool isReserved = [3, 4, 12, 18, 20, 25, 45, 50, 65, 72].contains(index);
    bool isSelected = selectedSeats.contains(index);

    Color color = isReserved
        ? Colors.grey.shade700
        : (isSelected ? const Color(0xFF2A34F9).withOpacity(0.2) : Colors.white);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: GestureDetector(
        onTap: isReserved ? null : () => onSeatSelected(index),
        child: Icon(Icons.event_seat, color: color, size: 26),
      ),
    );
  }
}
