import 'package:flutter/material.dart';

class TicketDetail extends StatelessWidget {
  final String label;
  final String value;
  const TicketDetail({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
