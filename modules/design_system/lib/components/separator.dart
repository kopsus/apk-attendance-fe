import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;
  const VerticalSeparator({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.safeBlockVertical*height,
    );
  }
}

class HorizontalSeparator extends StatelessWidget {
  final double width;
  const HorizontalSeparator({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal*width,
    );
  }
}

