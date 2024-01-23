import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui show Gradient;

class UsaIaScreen extends StatefulWidget {
  const UsaIaScreen({super.key});

  @override
  State<UsaIaScreen> createState() => _UsaIaScreenState();
}

class _UsaIaScreenState extends State<UsaIaScreen> {
  RecorderController recorderController = RecorderController(); // Initialise
  PlayerController playerController = PlayerController();
  late String path;
  late Directory directory;
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
        "${directory.path}${separator}${dateTime}.aac"; //è il nome del file audio
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        //recorderController.refresh();
        //1. devo salvare audio
        final path =
            await recorderController.stop(); //false permette di non resettare

        if (path != null) {
          isRecordingCompleted = true;

          playerController.preparePlayer(path: path);
          var url = Uri.parse("http://172.19.139.25:9000/transcribe_audio");
          //var url = Uri.parse("http://127.0.0.1:9000/transcribe_audio");
          var request = http.MultipartRequest('POST', url);

          var file = await http.MultipartFile.fromPath('audio', path);

          request.files.add(file);

          try {
            print("HEYYYYY SONO NELLA RICHIESTA INVIAT");
            var response = await request.send();

            if (response.statusCode == 200) {
              Get.snackbar("risposta",
                  'Risposta: ${await response.stream.bytesToString()}');
              //Get.snackbar("finito", "Recorded file size: ${File(path)}");
            }
          } catch (error) {
            print("object");
          }
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
        path = "${directory.path}${Platform.pathSeparator}${dateTime}.aac";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initialiseController();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: //padding sopra e a sinistra
                  EdgeInsets.only(
                      left: 30, top: MediaQuery.of(context).size.height / 9),
              child: Text(
                'Analizza Audio ',
                style: GoogleFonts.rubik(
                    color: const Color.fromARGB(255, 24, 24, 23),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
            Flex(
              direction: Axis.horizontal,
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
                const SizedBox(
                  width: 2,
                ),
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
            Spacer(),
            Flex(
              direction: Axis.horizontal,
              children: [
                SizedBox(
                  width: 280,
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
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
                const SizedBox(
                  width: 2,
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
          ],
        ));
  }
}
