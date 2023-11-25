import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController control;
  final String hintString;

  const CustomTextfield(
      {super.key, required this.control, required this.hintString});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.control,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0)),
          filled: true,
          fillColor: const Color.fromARGB(255, 203, 207, 209),
          labelText: widget.hintString,
          labelStyle: GoogleFonts.rubik(fontSize: 16, color: Colors.black),
        ));
  }
}
