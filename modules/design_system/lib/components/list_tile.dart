import 'package:flutter/material.dart';

class DistroListTile extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? trailing;

  const DistroListTile({super.key, required this.title, this.subTitle, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subTitle != null) subTitle!,
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
  
}