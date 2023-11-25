import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(16),
      child: Card(
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 7),
                    child: Text(_title, style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      //round the edges
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.blue),
                      ),
                      onPressed: _buttonFunction,
                      child: Text(
                        _buttonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
