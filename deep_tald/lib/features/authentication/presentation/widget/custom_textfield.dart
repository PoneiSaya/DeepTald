import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController control;
  final String hintString;
  final bool isObscureText;

  const CustomTextfield(
      {super.key,
      required this.control,
      required this.hintString,
      required this.isObscureText});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 317,
      child: TextField(
          controller: widget.control,
          obscureText: widget.isObscureText,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14.0)),
            filled: true,
            fillColor: const Color.fromARGB(166, 203, 207, 209),
            labelText: widget.hintString,
            labelStyle: GoogleFonts.montserrat(
                fontSize: 16, color: const Color.fromARGB(255, 157, 164, 167)),
          )),
    );
  }
}
