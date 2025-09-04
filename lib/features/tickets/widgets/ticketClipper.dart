import 'package:flutter/material.dart';
import 'package:movie_plex/features/tickets/widgets/ticketWidget.dart';

/// Single clipper for both horizontal and vertical tickets
class TicketClipper extends CustomClipper<Path> {

  TicketClipper();

  @override
  Path getClip(Size size) {
    double radius = 20;
    double cutoutY = size.height / 2.5;

    Path path = Path();

    path.moveTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius), clockwise: false);

    // Right side cutout
    path.lineTo(size.width, cutoutY - radius);
    path.arcToPoint(Offset(size.width, cutoutY + radius), radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius), clockwise: false);

    // Bottom line
    path.lineTo(radius, size.height);
    path.arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius), clockwise: false);

    // Left side cutout
    path.lineTo(0, cutoutY + radius);
    path.arcToPoint(Offset(0, cutoutY - radius), radius: Radius.circular(radius), clockwise: false);

    path.lineTo(0, radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
