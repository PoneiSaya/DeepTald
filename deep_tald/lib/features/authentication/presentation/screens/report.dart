import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/CustomCardListTile.dart';
import '../widget/customexpansionpanel.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _Report();
}

bool visualizzaMedici = false;

class _Report extends State<ReportPage> {
  TextEditingController ricercaController = TextEditingController();

  final List<Item> _data = generateItems(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 30, top: MediaQuery.of(context).size.height / 9),
                  child: Text(
                    'I Miei Report 📝',
                    style: GoogleFonts.rubik(
                      color: const Color.fromARGB(255, 24, 24, 23),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Padding(
                  padding: EdgeInsets.only(
                      left: 35, top: MediaQuery.of(context).size.height / 200),
                  child: Text(
                    'Ultime analisi:',
                    style: GoogleFonts.rubik(
                      color: const Color.fromARGB(255, 24, 24, 23),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: CustomExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data[index].isExpanded = !isExpanded;
                      });
                    },
                    key: null,
                    children: _data.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "12/11/2001",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            tileColor: Colors
                                .transparent, // Per evitare il colore di sfondo predefinito
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                        body: Column(children: [
                          CustomCardListTile("Perseveranza"),
                          CustomCardListTile("Ruminazione"),
                          CustomCardListTile("Pensiero\nRallentato"),
                          CustomCardListTile("Logorrea"),
                        ]),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: const Color.fromARGB(166, 203, 207, 209),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: ricercaController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {},
                  ),
                  labelText: visualizzaMedici
                      ? "Cerca Medico con Codice Fiscale"
                      : "Cerca Paziente con Codice Fiscale",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Pannello $index',
      expandedValue: 'Contenuto del pannello $index',
    );
  });
}
