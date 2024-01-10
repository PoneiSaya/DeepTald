import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

List<Message> messagesList = List.empty(growable: true);

class _ChatbotScreenState extends State<ChatbotScreen> {
  final ChatUser utente = ChatUser(id: '2', name: "Utente");
  final chatController = ChatController(
    initialMessageList: messagesList,
    scrollController: ScrollController(),
    chatUsers: [
      ChatUser(id: '1', name: 'Bob'),
      ChatUser(id: '2', name: 'Utente')
    ],
  );

  void onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final int id;
    if (messagesList.isEmpty) {
      id = 1;
    } else {
      id = int.parse(messagesList.last.id) + 1;
    }
    chatController.addMessage(
      Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message, //testo
        sendBy: "Utente",
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
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
        textFieldBackgroundColor: Color.fromARGB(255, 234, 35, 35),

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
          backgroundColor: Colors.red,
          //borderColor: theme.messageReactionBackGroundColor,
          reactedUserCountTextStyle: TextStyle(color: Colors.black),
          reactionCountTextStyle: TextStyle(color: Colors.black),
          reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
            //backgroundColor: theme.backgroundColor,
            reactedUserTextStyle: TextStyle(color: Colors.amber),
            reactionWidgetDecoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: true
                      ? Colors.black12
                      : const Color.fromARGB(255, 136, 26, 26),
                  offset: const Offset(0, 20),
                  blurRadius: 40,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        imageMessageConfig: ImageMessageConfiguration(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          shareIconConfig: ShareIconConfiguration(
            defaultIconBackgroundColor: Colors.orange,
            defaultIconColor: Colors.orange,
          ),
        ),
      ),
    ));
  }
}
