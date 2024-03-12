import 'package:design_system/foundation/colors.dart';
import 'package:flutter/material.dart';

class DistroCard extends StatelessWidget {
  final Widget child;
  const DistroCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: DistroColors.tertiary_50,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 16,
            spreadRadius: -6,
            color: Color(0xff18274B).withOpacity(.08)
          ),
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 8,
            spreadRadius: -6,
            color: Color(0xff18274B).withOpacity(.12)
          )
        ]
      ),
      child: child,
    );
  }
}