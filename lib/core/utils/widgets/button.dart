import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color? color;


  const Button({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.color = Colors.blueAccent 
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white
        ),
      ),
    );
  }
}