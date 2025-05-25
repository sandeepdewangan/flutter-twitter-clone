import 'package:flutter/material.dart';

class SmallRoundedButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  const SmallRoundedButton({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 5,
      label: Text(label, style: TextStyle(fontSize: 15, color: textColor)),
      backgroundColor: bgColor,
    );
  }
}
