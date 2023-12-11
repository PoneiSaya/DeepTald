import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const Button({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF599BFF),
          foregroundColor: Colors.white,
          fixedSize: const Size(259, 65)),
      child: Text(
        buttonText,
        style: GoogleFonts.rubik(
            color: const Color.fromRGBO(255, 255, 255, 1),
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontSize: 24),
      ),
    );
  }
}
