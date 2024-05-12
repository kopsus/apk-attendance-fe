import 'package:design_system/components/separator.dart';
import 'package:design_system/foundation/colors.dart';
import 'package:flutter/material.dart';

class DistroAlertDialog extends StatelessWidget {
  final List<Widget> contents;
  final List<Widget> actions;
  const DistroAlertDialog(
      {super.key, required this.contents, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DistroColors.white,
      surfaceTintColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...contents,
          actions.isEmpty ? const SizedBox.shrink() : const VerticalSeparator(height: 2),
          actions.length == 1
              ? actions[0]
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions)
        ],
      ),
    );
  }
}
