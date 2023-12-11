import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ChatBot extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatBot> {
  List<Message> messages = [];
  bool isRecording = false;
  late AudioPlayer audioPlayer;
  final recorder = AudioRecorder();
  String recordedFilePath = "";

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children:
                  messages.map((message) => _buildMessage(message)).toList(),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    final isUserMessage = !message.isBot;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: message.isAudio
                ? Column(
                    children: [
                      Icon(Icons.audiotrack, color: Colors.white),
                      Text('Audio Message'),
                    ],
                  )
                : Text(
                    message.text,
                    style: TextStyle(color: Colors.black),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              iconSize: 67,
              onPressed: () async {
                if (isRecording) {
                  await _stopRecording();
                } else {
                  await _startRecording();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {
    var status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = '${appDocDir.path}/file_$timestamp.mp3';

      await recorder.start(const RecordConfig(), path: filePath);

      setState(() {
        isRecording = true;
        recordedFilePath = filePath;
      });
    } else if (status == PermissionStatus.denied) {
      _showPermissionDeniedDialog();
    } else {
      print(
          "L'utente ha negato il permesso con la possibilità di non mostrare ulteriori richieste");
    }
  }

  Future<void> _stopRecording() async {
    await recorder.stop();

    // Utente audio
    setState(() {
      isRecording = false;
      messages.add(Message(
          isBot: false, isAudio: true, isText: false, text: recordedFilePath));
    });

    //qua vado a rispondere con il bot
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.add(Message(
            isBot: true,
            isAudio: false,
            isText: true,
            text: 'Audio registrato godo!'));
      });
    });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permesso Microfono Negato'),
          content: Text(
              'Per favore, concedi i permessi del microfono nelle impostazioni dell\'app per utilizzare questa funzione.'),
          actions: [
            TextButton(
              child: Text('Chiudi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Apri Impostazioni'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Message {
  final bool isBot;
  final bool isAudio;
  final bool isText;
  final String text;

  Message({
    required this.isBot,
    required this.isAudio,
    required this.isText,
    required this.text,
  });
}
