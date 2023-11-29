import 'package:deep_tald/features/authentication/presentation/screens/medico_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/paziente_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var tabIndex = 0;
  List<Widget> pagine = const [
    Center(
      child: CircularProgressIndicator(),
    )
  ];

  //allo start dell'applicazione

  void setUpForMedico() {
    pagine = const [MedicoScreen(), ProfileScreen()];
    update();
  }

  void setUpForPaziente() {
    pagine = const [PazienteScreen(), ProfileScreen()];
    update();
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  get getPagine => pagine;

  /**
   * TODO 
   * Fare metodo che restituisce l'array di elementi della navbar vedendo che tipo di user
   */
}
