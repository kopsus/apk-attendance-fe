import 'package:flutter/material.dart';

class DistroAlertDialog extends StatelessWidget {
  final List<Widget> contents;
  final List<Widget> actions;
  const DistroAlertDialog({super.key, required this.contents, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(24),
      content: Column(
        children: [
          ...contents,
          actions.isEmpty ? SizedBox(height: 16) : SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions
          )
        ],
      ),
    );
  }
}