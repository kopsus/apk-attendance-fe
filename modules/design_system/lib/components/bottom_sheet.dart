import 'package:design_system/components/separator.dart';
import 'package:design_system/foundation/colors.dart';
import 'package:design_system/foundation/typography.dart';
import 'package:flutter/material.dart';

class DistroBottomSheet extends StatelessWidget {
  final Widget image;
  final String title;
  final String desc;
  final Widget action;
  const DistroBottomSheet({
    super.key, 
    required this.image,
    required this.title,
    required this.desc,
    required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: DistroColors.white,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.clear_rounded, size: 15, color: DistroColors.black)
            ],
          ),
          const VerticalSeparator(height: 2),
          image,
          const VerticalSeparator(height: 2),
          Text(title, style: DistroTypography.bodyLargeSemiBold.copyWith(
            color: DistroColors.tertiary_700
          )),
          const VerticalSeparator(height: 1),
          Text(desc, style: DistroTypography.bodySmallRegular.copyWith(
            color: DistroColors.black
          )),
          const VerticalSeparator(height: 2),
          action
        ],
      ),
    );
  }
}