import 'package:flutter/material.dart';
import 'package:movie_plex/common_widgets/customButton.dart';
import 'package:movie_plex/data/models/ticket_model.dart';
import 'package:movie_plex/features/tickets/widgets/ticketClipper.dart';
import 'package:movie_plex/features/tickets/widgets/ticketWidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_plex/core/constants/app_colors.dart';

// ignore: must_be_immutable
class TicketScreen extends StatefulWidget {
  TicketModel ticket;
  TicketScreen({super.key, required this.ticket});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool showTicket = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => showTicket = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ticketHeight = size.height * 0.7;
    final ticketWidth = double.infinity;

    final now = DateTime.now();
    final isExpired = widget.ticket.movie_time.isBefore(now);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: showTicket
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TicketWidget(ticket: widget.ticket),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ClipPath(
                      clipper: TicketClipper(),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          width: ticketWidth,
                          height: ticketHeight,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 30),
          Visibility(
            visible: showTicket && (!widget.ticket.paid || isExpired),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                color: isExpired ? Colors.red : AppColors.primary,
                height: 50,
                hasIcon: false,
                textColor: isExpired ? Colors.white : AppColors.bg,
                text: isExpired ? "Delete Ticket" : "Buy Ticket now",
                press: () {
                  if (isExpired) {
                    // Add delete ticket logic here
                  } else {
                    // Add buy ticket logic here
                  }
                },
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
