import 'package:deep_tald/features/authentication/presentation/screens/paziente_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/profile_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var tabIndex = 0;
  List<Widget> pagine = const [PazienteScreen(), ProfileScreen()];

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  get getPagine => pagine;

  /**
   * TODO 
   * Fare metodo che restituisce l'array di elementi della navbar vedendo che tipo di utente sei
   */
}
