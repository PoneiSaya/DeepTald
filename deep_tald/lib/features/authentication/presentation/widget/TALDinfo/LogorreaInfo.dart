import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoggoreaInfo extends StatelessWidget {
  const LoggoreaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 228, 247),
        borderRadius: BorderRadius.circular(10.0), 
        ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 102, 169, 224),
                borderRadius: BorderRadius.circular(10),
                ),
              padding: EdgeInsets.all(10),
              child: Text("Logorrea",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white
                      )
                    )
              ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.rubik(
                  fontSize: 14,
                  color: Colors.black
                  ),
                children: const [
                  TextSpan(
                    text: "An excessively strong need to talk. Logorrheic speech itself can be coherent and logical. There is no need for accelerated"+
                    "speech production. \n"
                  ),
                  TextSpan(
                    text: "Communication with the patient is hampered. The patient is unable to recognize when he is interrupted or simply ignores such interruptions. \n\n"
                  ),
                  TextSpan(
                    text: "Different phenomena: \n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "Speech under pressure(o) \n\n"
                  ),
                  TextSpan(
                    text: "Evaluation\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "0 = not present\n1 = doubtful \n2 = mild: it is possible to interrupt the flow of words. With some exceptions,"+
                    "the patient is able to concentrate on the examiner \n"
                  ),
                  TextSpan(
                    text: "3 = moderate: is is difficult to interrupt the flow of words. The patient is unable to concentrate on the examiner\n"
                  ),
                  TextSpan(
                    text: "4 = severe: communication with the patient is greatly impaired. Attempts to interrupt the patient are either not noticed"+
                    "at all or are deliberately ignored"
                  )
                ]
              ),
            ),
          ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Allinea i widget alla fine (a destra)
              children: [
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 102, 169, 224),
                  ),
                child: TextButton(
                  child: const Text('Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                      )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ]
            )
          ],
      ),
    );
  }
}