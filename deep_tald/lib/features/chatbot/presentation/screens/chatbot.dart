import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

List<Message> messagesList = List.empty(growable: true);

class _ChatbotScreenState extends State<ChatbotScreen> {
  final ChatUser utente = ChatUser(id: '1', name: "Utente");
  final chatController = ChatController(
    initialMessageList: List.empty(growable: true),
    scrollController: ScrollController(),
    chatUsers: [
      ChatUser(id: '1', name: 'Utente'),
      ChatUser(id: '2', name: 'Bob')
    ],
  );

  void onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    int id;
    if (messageType == MessageType.voice) {
      id = 1;
    } else {
      id = 2;
    }

    chatController.addMessage(
      Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message,
        sendBy: id.toString(),
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    //Qui si richiama LLAMA per ottenere la risposta
    creaMessaggio(message);
  }

  /// Qui si deve richiamare LLAMA per generare una domanda
  void creaMessaggio(String path) async {
    //fare la richiesta
    var urlChatbot = Uri.parse("http://172.19.190.93:9000/transcribe_audio");
    var request = http.MultipartRequest('POST', urlChatbot);
    String testoLLAMA = "";

    var file = await http.MultipartFile.fromPath('audio', path);
    request.files.add(file);

    Get.snackbar("title", file.toString());

    try {
      print("MAMMT       ---      ");
      var response = await request.send();

      if (response.statusCode == 200) {
        testoLLAMA = await response.stream.bytesToString();
      }
    } catch (error) {
      print("--------------------ERRORE---------");
      print(error);
    }

    chatController.addMessage(Message(
        message: testoLLAMA, createdAt: DateTime.now(), sendBy: 2.toString()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ChatView(
            featureActiveConfig: const FeatureActiveConfig(
                enableReactionPopup: false,
                enableSwipeToReply: false,
                enableSwipeToSeeTime: false,
                enableOtherUserProfileAvatar: false,
                enableReplySnackBar: false,
                enableDoubleTapToLike: false,
                enableTextField: true),
            currentUser: this.utente,
            chatController: chatController,
            onSendTap: onSendTap,
            chatViewState: ChatViewState.hasMessages,
            sendMessageConfig: const SendMessageConfiguration(
              //replyMessageColor: Colors.black,
              allowRecordingVoice: true,
              enableCameraImagePicker: false,
              replyMessageColor: Colors.black,
              enableGalleryImagePicker: false,
              defaultSendButtonColor: Colors.black,
              replyDialogColor: Colors.black,
              replyTitleColor: Color.fromARGB(255, 223, 55, 55),
              textFieldBackgroundColor: Color.fromARGB(255, 245, 246, 250),

              closeIconColor: Colors.black,
              textFieldConfig: TextFieldConfiguration(
                textInputType: TextInputType.text,
                hintText: "",

                // compositionThresholdTime: Duration(seconds: 1),
                textStyle: TextStyle(color: Color.fromARGB(255, 203, 203, 203)),
              ),
              micIconColor: Colors.black,

              voiceRecordingConfiguration: VoiceRecordingConfiguration(
                backgroundColor: Colors.orange,
                recorderIconColor: Colors.black,
                waveStyle: WaveStyle(
                  showMiddleLine: false,
                  waveColor: Colors.white,
                  extendWaveform: true,
                ),
              ),
            ),
            messageConfig: MessageConfiguration(
              messageReactionConfig: MessageReactionConfiguration(
                backgroundColor: const Color.fromARGB(255, 245, 246, 250),
                //borderColor: theme.messageReactionBackGroundColor,
                reactedUserCountTextStyle: const TextStyle(color: Colors.black),
                reactionCountTextStyle: const TextStyle(color: Colors.black),
                reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                  //backgroundColor: theme.backgroundColor,
                  reactedUserTextStyle: const TextStyle(color: Colors.amber),
                  reactionWidgetDecoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 20),
                        blurRadius: 40,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              imageMessageConfig: ImageMessageConfiguration(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                shareIconConfig: ShareIconConfiguration(
                  defaultIconBackgroundColor: Colors.orange,
                  defaultIconColor: Colors.orange,
                ),
              ),
            ),
            chatBubbleConfig: const ChatBubbleConfiguration(
              inComingChatBubbleConfig: ChatBubble(color: Colors.blue),
              outgoingChatBubbleConfig: ChatBubble(color: Colors.blue),
            )));
  }
}
