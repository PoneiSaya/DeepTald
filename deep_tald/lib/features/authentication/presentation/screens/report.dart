import 'package:deep_tald/features/authentication/controllers/reports_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/WidgetLogorrea.dart';
import 'package:deep_tald/features/authentication/presentation/widget/WidgetPensieroRallentato.dart';
import 'package:deep_tald/features/authentication/presentation/widget/WidgetPerseveranza.dart';
import 'package:deep_tald/features/authentication/presentation/widget/WidgetRuminazione.dart';
import 'package:deep_tald/model/entity/report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/CustomCardListTile.dart';
import 'package:intl/intl.dart';
import '../widget/customexpansionpanel.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _Report();
}

bool visualizzaMedici = false;

class _Report extends State<ReportPage> {
  late List<Report> reports = List.empty(growable: true);
  bool isDataInitialized = false;
  _asyncMethod() async {
    reports = await reportController.findReportsByUserId(uidPaziente);
  }

  @override
  void initState() {
    super.initState();

    // Recupera i parametri durante l'inizializzazione dello stato
    Map<String, dynamic> params = Get.parameters;
    uidPaziente = params['uidPaziente'];
    _asyncMethod();
    // Ora puoi utilizzare uidPaziente come desiderato
    print('UID Paziente: $uidPaziente');
    //_data = generateItems(reports);

    //QUANDO reports cambia genera una nuova lista di Item
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _data = generateItems(reports);
        isDataInitialized = true;
      });
    });
  }

  TextEditingController ricercaController = TextEditingController();
  ReportController reportController = Get.put(ReportController());
  // Recupera il valore di uidPaziente
  late String uidPaziente;

  late List<Item> _data;

  @override
  Widget build(BuildContext context) {
    //passa userid a questa page

    reportController.findReportsByUserId(uidPaziente);
    return !isDataInitialized
        ? Center(
            child: //Circula progress indicator con sfondo bianco
                Stack(
              children: [
                //CircularProgressIndicator(), con testo "Caricamento..."
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 24, 24, 23)),
                      ),
                      Text("Caricamento Reports...",
                          style: GoogleFonts.rubik(
                              color: const Color.fromARGB(255, 24, 24, 23),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                              fontSize: 24)),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 246, 250),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: //padding sopra e a sinistra
                      EdgeInsets.only(
                          left: 30,
                          top: MediaQuery.of(context).size.height / 9),
                  child: Text(
                    'Reports 📑',
                    style: GoogleFonts.rubik(
                        color: const Color.fromARGB(255, 24, 24, 23),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                ),
                Expanded(
                  //flex: 8,
                  child: ListView(
                    children: [
                      //SizedBox(height: MediaQuery.of(context).size.height / 35),
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
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
                              _data[index].isExpanded =
                                  !_data[index].isExpanded;
                            });
                          },
                          key: null,
                          children: _data.map<ExpansionPanel>((Item item) {
                            return ExpansionPanel(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            item.headerValue,
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.rubik(
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),

                                    tileColor: Colors
                                        .transparent, // Per evitare il colore di sfondo predefinito
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                },
                                body: Column(children: [
                                  CustomCardListTile(
                                    "Perseveranza",
                                    item.report.perseveranceObj.getScore,
                                    WidgetPerseveranza(
                                        item.report.perseveranceObj),
                                  ),
                                  CustomCardListTile(
                                      "Ruminazione",
                                      item.report.ruminazioneObj.getScore,
                                      RuminazioneWidget(
                                          item.report.ruminazioneObj)),
                                  CustomCardListTile(
                                      "Pensiero\nRallentato",
                                      item.report.slowedThinkingObj.getScore,
                                      PensieroRallentatoWidget(
                                          item.report.slowedThinkingObj)),
                                  CustomCardListTile(
                                      "Logorrea",
                                      item.report.logorreaObj.getScore,
                                      LogorreaWidget(item.report.logorreaObj)),
                                ]),
                                isExpanded: !item.isExpanded);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF599BFF),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(259, 65)),
                    child: Text(
                      "Ricerca per Data",
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () async {
                      final DateTime? dataQuery = await showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          firstDate: DateTime(2024, 1),
                          lastDate: DateTime.now());

                      var listaReports = await reportController
                          .findReportsByUserIdAndDate(uidPaziente, dataQuery!);

                      setState(() {
                        reports = listaReports;

                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            _data = generateItems(reports);
                            isDataInitialized = true;
                          });
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = true,
    required this.report,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  Report report;
}

List<Item> generateItems(List<Report> reports) {
  return List.generate(reports.length, (int index) {
    String formattedDate =
        DateFormat('dd/MM/yyyy hh:mm').format(reports[index].dataVisita);
    return Item(
      headerValue: formattedDate,
      expandedValue: reports[index].toString(),
      report: reports[index],
    );
  });
}
