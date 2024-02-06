import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PensieroRallentatoInfo extends StatelessWidget {
  const PensieroRallentatoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
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
                child: Text("Pensiero Rallentato",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white))),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: RichText(
              text: TextSpan(
                  style: GoogleFonts.rubik(fontSize: 14, color: Colors.black),
                  children: const [
                    TextSpan(
                        text: "From the observer's point of view, the patients' thinking process appears to be slowed down (objective)." +
                            " As a result of this slow thought process, the conversation is languid and sluggish. \n\n"),
                    TextSpan(
                        text: "Different phenomena: \n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "Inhibited thinking (i) \n"),
                    TextSpan(text: "Poverty of speech (o) \n\n"),
                    TextSpan(
                        text: "Evaluation\n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "0 = not present.\n1 = doubtful: a possible slowed down thought process; however," +
                            "the flow of the conversation or exploration is not affected.\n"),
                    TextSpan(
                        text:
                            "2 = mild: examiner notes slow thought process and flow of conversation or exploration is slightly affected.\n"),
                    TextSpan(
                        text:
                            "3 = moderate: examiner notes slow thought process and flow of conversation or exploration is considerably limited.\n"),
                    TextSpan(
                        text: "4 = severe: due to the slow train of thoughts of the patient and the long pauses in the conversation," +
                            "the flow of the conversation is so limited that an exploration is not possible or only proceeds with great effort.")
                  ]),
            ),
          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment
                  .end, // Allinea i widget alla fine (a destra)
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
                            fontSize: 14)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ])
        ],
      ),
    ));
  }
}
