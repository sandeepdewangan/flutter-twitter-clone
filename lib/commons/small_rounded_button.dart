import 'package:flutter/material.dart';

class SmallRoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color bgColor;
  final Color textColor;
  const SmallRoundedButton({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        elevation: 5,
        label: Text(label, style: TextStyle(fontSize: 15, color: textColor)),
        backgroundColor: bgColor,
      ),
    );
  }
}
