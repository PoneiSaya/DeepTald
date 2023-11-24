import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 188,
            ),
            Image.asset(
              "assets/images/brain.png",
              height: 118,
              width: 118,
            ),
            const SizedBox(
              height: 34,
            ),
            Center(
                child: Text('Benvenuto in',
                    style: GoogleFonts.rubik(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none))),
            Center(
              child: Text(
                "Deep Tald",
                style: GoogleFonts.rubik(
                    color: Color(0xFF599BFF),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            Center(
              child: Text(
                "Understanding Mental Health",
                style: GoogleFonts.rubik(
                    color: Color.fromRGBO(154, 164, 167, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            Column(children: [
              const SizedBox(
                height: 130,
              ),
              Button(
                buttonText: "Entra",
                onPressed: () {},
              )
            ]),
          ],
        ));
  }
}
