import 'dart:io';

import 'package:deep_tald/features/authentication/controllers/auth_controller.dart';
import 'package:deep_tald/features/authentication/controllers/medico_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/user_card.dart';
import 'package:deep_tald/model/dto/utenteDto.dart';
import 'package:deep_tald/model/entity/medico.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UsaIaScreen extends StatefulWidget {
  const UsaIaScreen({super.key});

  @override
  State<UsaIaScreen> createState() => _UsaIaScreenState();
}

class _UsaIaScreenState extends State<UsaIaScreen> {
  bool isRegistrato = false;
  AuthController authController = Get.find();
  MedicoController medicoController = Get.put(MedicoController());
  RecorderController recorderController = RecorderController(); // Initialise
  PlayerController playerController = PlayerController();
  late String path;
  late Directory directory;
  late String nome;
  late String uid;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  String dateTime = "";

  Future<void> _initialiseController() async {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000
      ..updateFrequency = const Duration(milliseconds: 70)
      ..currentScrolledDuration;
    var separator = Platform.pathSeparator;
    directory = await getApplicationDocumentsDirectory();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd-HH-mm-ss");
    dateTime = dateFormat.format(DateTime.now());
    path =
        "${directory.path}$separator$dateTime.aac"; //è il nome del file audio
  }

  void _startOrStopRecording() async {
    try {
      isRegistrato = true;
      if (isRecording) {
        //recorderController.refresh();
        //1. devo salvare audio
        final path =
            await recorderController.stop(); //false permette di non resettare

        if (path != null) {
          isRecordingCompleted = true;

          playerController.preparePlayer(path: path);
          /*
          var url = Uri.parse("http://172.19.139.25:9000/transcribe_audio");
          var request = http.MultipartRequest('POST', url);

          var file = await http.MultipartFile.fromPath('audio', path);

          request.files.add(file);

          try {
            var response = await request.send();

            if (response.statusCode == 200) {
              Get.snackbar("risposta",
                  'Risposta: ${await response.stream.bytesToString()}');
              //Get.snackbar("finito", "Recorded file size: ${File(path)}");
            }
          } catch (error) {
            print("object");
          }*/
        }
      } else {
        //se non sta registrando allora inizia a registrare
        await recorderController.record(path: path);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording; //aggiorna lo stato
        path = "${directory.path}${Platform.pathSeparator}$dateTime.aac";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initialiseController();
    //prendi gli argomenti passati
    if (Get.arguments == null) {
      nome = "";
      uid = "";
    } else {
      nome = Get.arguments[1];
      uid = Get.arguments[0];
    }
  }

  @override
  void dispose() {
    super.dispose();
    recorderController.dispose();
    playerController.dispose();
  }

  void _playandPause() async {
    playerController.playerState == PlayerState.playing
        ? await playerController.pausePlayer()
        : await playerController.startPlayer(finishMode: FinishMode.pause);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 246, 250),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //bottone che apre una modale per selezionare un paziente
            //testo di info su come usare l'IA

            Padding(
              padding: //padding sopra e a sinistra
                  EdgeInsets.only(
                      left: 30, top: MediaQuery.of(context).size.height / 9),
              child: Text(
                'Analizza Audio di $nome!',
                style: GoogleFonts.rubik(
                    color: const Color.fromARGB(255, 24, 24, 23),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    child: AudioFileWaveforms(
                  size: const Size(280, 50),
                  playerController: playerController,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle: const PlayerWaveStyle(
                    scaleFactor: 500,
                    showSeekLine: false,
                    waveCap: StrokeCap.butt,
                    fixedWaveColor: Color.fromARGB(77, 17, 12, 12),
                    liveWaveColor: Color.fromARGB(255, 2, 2, 2),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color(0xFF599BFF),
                  ),
                  //padding: const EdgeInsets.only(left: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                )),
                ElevatedButton(
                    onPressed: () {
                      playerController.startPlayer();
                      _playandPause();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 245, 246, 250),
                      foregroundColor: const Color(0xFF599BFF),
                      fixedSize: const Size(50, 50),
                    ),
                    child: const Icon(Icons.play_arrow))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 7),
            //se non stai registrando allora mostra un bottone con su scritto ANALIZZA AUDIO
            if (!isRecording && isRegistrato)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //sized box con media query
                      Image.asset(
                        "assets/images/ia.png",
                        width: 100,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //manda richiesta http con l'audio e l'uid del paziente al server
                          var url =
                              Uri.parse("http://192.168.183.1:9099/usa_ia");
                          var request = http.MultipartRequest('POST', url);

                          var file =
                              await http.MultipartFile.fromPath('audio', path);

                          request.files.add(file);
                          //manda l'uid del paziente
                          request.fields['id'] = uid;

                          //non aspettare la risposta del server
                          sendAudio(request);
                          //esci dalla pagina e metti uno snackbar
                          Get.snackbar("Analisi in corso",
                              "Troverai i risultati nell'area report del paziente analizzato!");

                          //fai il pop della pagina
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF599BFF),
                          onPrimary: const Color.fromARGB(255, 245, 246, 250),
                          fixedSize: const Size(280, 50),
                        ),
                        child: const Text('Analizza Audio!'),
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 280,
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: AudioWaveforms(
                      enableGesture: true,
                      size: const Size(280, 50),
                      recorderController: recorderController,
                      waveStyle: const WaveStyle(
                        scaleFactor: 50,
                        waveColor: Colors.white,
                        extendWaveform: true,
                        showMiddleLine: false,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color(0xFF599BFF),
                      ),
                      padding: const EdgeInsets.only(left: 18),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _startOrStopRecording();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 246, 250),
                    foregroundColor: const Color(0xFF599BFF),
                    fixedSize: const Size(50, 50),
                  ),
                  child: isRecording
                      ? const Icon(Icons.send)
                      : const Icon(Icons.mic_rounded),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  //fai una richiesta http al server con l'audio e l'uid del paziente
  Future<http.StreamedResponse> sendAudio(http.MultipartRequest request) async {
    return request.send();
  }

  //metodo che builda la lista di pazienti usando il metodo getPazientiAssociati
  Future<Widget> buildListPazienti() async {
    return FutureBuilder(
        future: medicoController.getPazientiAssociati(await medicoController
            // ignore: invalid_use_of_protected_member
            .getIdMedico(authController.utente!.getEmail)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.black,
            );
          } else if (snapshot.hasError) {
            return Text('Errore: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              List<UtenteDTO> elencoPazienti = snapshot.data as List<UtenteDTO>;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: elencoPazienti.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      nome: elencoPazienti[index].getNome,
                      cognome: elencoPazienti[index].getCognome,
                      ruolo: elencoPazienti[index].getRuolo,
                      uid: elencoPazienti[index].getUid,
                      analizza: true,
                    );
                  });
            } else {
              return const Text("Non ci sono pazienti associati");
            }
          }
        });
  }
}
