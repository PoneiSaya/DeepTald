import 'package:get/get.dart';

class iaPageController extends GetxController {
  ///Con questo metodo si fa una richiesta per fare upload del vocale nel server
  Future<void> uploadAudio() async {
    var url = 'http://127.0.0.1:5000/upload';
  }
}
