import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpacing;

  const DottedDivider({super.key, this.height = 1, this.dashWidth = 6, this.dashSpacing = 4});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpacing)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return Container(
                width: dashWidth,
                height: height,
                color: Color.fromARGB(255, 255, 236, 178),
              );
            }),
          );
        },
      ),
    );
  }
}
