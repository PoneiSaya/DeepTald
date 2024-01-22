import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RuminazioneInfo extends StatelessWidget {
  const RuminazioneInfo({super.key});

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
              child: Text("Ruminazione",
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
                    text: "The patient is constantly occupied with monstly unpleasant topics. These thoughts are centered around the same topics"+
                    " without leading to any conclusions."
                  ),
                  TextSpan(
                    text: " It is difficult for the patient to interupt these negative thought processes."
                  ),
                  TextSpan(
                    text: " Rumination is experienced as unpleasant and in some cases even tortuous.\n\n"
                    ),
                  TextSpan(
                    text: "Different phenomena: \n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "Narrow thinking (o)\n",
                  ),
                  TextSpan(
                    text: "Poverty of thought (s)\n\n",
                  ),
                  TextSpan(
                    text: "Evaluation: \n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "0 = not present.\n1 = doubtful. \n2 = mild: rumination occurs and patient is mildly affected but still able to handle"+
                    " daily responsibilities.\n"
                  ),
                  TextSpan(
                    text: "3 = moderate: the patient is disturbed by his ruminations. His day-to-day responsibilities and well-being are affected.\n"
                  ),
                  TextSpan(
                    text: "4 = severe: the patient is greatly tormented by his ruminations. His daily responsibilities and well-being are severely compromised."
                  )
                ]
              ),
            ),
          ),
          SizedBox(height:20),
            Center(
              child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 102, 169, 224),
                borderRadius: BorderRadius.circular(10),
                ),
              padding: EdgeInsets.all(10),
              child: Text("In-depth information",
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
                    text: "BERT,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: " is an advanced language model developed in the field of artificial intelligence.\n"
                  ),
                  TextSpan(
                    text: "He has been trained on a large body of text to develop a deep understanding of the semantic and syntactic relationships "+
                    "within words and sentences. \n"
                    ),
                    TextSpan(
                    text: "BERT,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: " represents words contextually, considering the surrounding context in which it appears. \n\n"
                  ),
                  TextSpan(
                    text: "The concept of ",
                  ),
                  TextSpan(
                    text: "similarity",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: " in the context of "
                  ),
                  TextSpan(
                    text: "BERT,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: " refers to the ability to evaluate how semantically similar two pieces of text are. \n"
                  ),
                  TextSpan(
                    text: "In other words, "
                  ),
                  TextSpan(
                    text: "BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "can calculate how much two sentences share similar information or represent related concepts.\n"
                  ),
                  TextSpan(
                    text: "This ability comes from its contextual understanding of words: if two sentences share similar keywords or grammatical structures,"
                  ),
                  TextSpan(
                    text: " BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "will be able to identify that similarity. \n\n"
                  ),
                  TextSpan(
                    text: "In practice, "
                  ),
                  TextSpan(
                    text: " BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "evaluates the similarity between sentences by calculating a sort of \"similarity score\".\n"
                  ),
                  TextSpan(
                    text: "This score reflects how much the sentences overlap in terms of meaning.\n"
                  ),
                  TextSpan(
                    text: "For example, if two sentences deal with the same topic or express similar concepts,\n"
                  ),
                  TextSpan(
                    text: " BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "will assign them a higher similarity score. This process is of great use in many applications, such as information retrieval,"+ 
                      "semantic search, and context understanding in search engines and natural language processing systems.\n\n"
                  ),
                  TextSpan(
                    text: "However, the potential of "
                  ),
                  TextSpan(
                    text: " BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "goes beyond similarity assessment. One notable application is "
                  ),
                  TextSpan(
                    text: "sentiment analysis.\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "In summary,"
                  ),
                  TextSpan(
                    text: " BERT, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "uses its contextual understanding of language not only to assess similarity between texts, but also for "
                  ),
                  TextSpan(
                    text: "sentiment analysis.\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: "This skill opens up a wide range of applications, from advanced natural language processing to creating "+
                    "tools that can understand and respond to the nuances of human emotion expressed through text."
                  ),
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
          ),
          ],
      ),
    ),
    );
  }
}