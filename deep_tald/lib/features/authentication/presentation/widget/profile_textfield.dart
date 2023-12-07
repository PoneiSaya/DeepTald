import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileField extends StatelessWidget {
  final String label;

  const ProfileField({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: 317,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: const Color.fromARGB(166, 203, 207, 209),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: const Color.fromARGB(255, 157, 164, 167),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
