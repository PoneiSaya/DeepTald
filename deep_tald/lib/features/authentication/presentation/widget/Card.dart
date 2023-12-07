import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDeepTald extends StatelessWidget {
  final String _imageUrl;
  final String _title;
  final String _buttonText;
  final Function() _buttonFunction;

  const CardDeepTald(
      this._imageUrl, this._title, this._buttonText, this._buttonFunction,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: MediaQuery.of(context).size.height / 4.7,
      margin: const EdgeInsets.all(16),
      child: Card(
        color: const Color.fromRGBO(191, 223, 225, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                _imageUrl,
                //metti l'immagine tutto a destra
                alignment: Alignment.centerRight,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all((MediaQuery.of(context).size.height / 60)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 70),
                    child: Text(
                      _title,
                      style: GoogleFonts.rubik(
                          color: const Color.fromARGB(255, 24, 24, 23),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  Padding(
                      padding: const EdgeInsets.all(0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 19.5,
                        child: ElevatedButton(
                          //round the edges
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 89, 155, 255)),
                          ),
                          onPressed: _buttonFunction,
                          child: Text(
                            _buttonText,
                            style: GoogleFonts.rubik(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
