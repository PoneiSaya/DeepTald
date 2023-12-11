import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_tald/features/authentication/presentation/screens/admin_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/gestione_utenti.dart';
import 'package:deep_tald/features/authentication/presentation/screens/medico_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/paziente_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:deep_tald/features/authentication/presentation/screens/report.dart';
import 'package:deep_tald/features/authentication/presentation/screens/usa_ia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var tabIndex = 0;

  List<Widget> pagine = [MedicoScreen(), UsaIaScreen(), ProfileScreen()];
  late List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_customize_rounded), label: "IA"),
    BottomNavigationBarItem(
        icon: Icon(Icons.manage_accounts_rounded), label: "Profilo")
  ];

  //allo start dell'applicazione

  void setUpForMedico() {
    pagine = const [MedicoScreen(), UsaIaScreen(), ProfileScreen()];
    items = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize_rounded), label: "Usa IA"),
      BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts_rounded), label: "Profilo")
    ];
    update();
  }

  void setUpForPaziente() {
    pagine = const [PazienteScreen(), ReportScreen(), ProfileScreen()];
    items = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize_rounded), label: "Reports"),
      BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts_rounded), label: "Profilo")
    ];
    update();
  }

  void setUpForAdmin() {
    pagine = const [AdminPage(), GestioneUtentiPage(), ProfileScreen()];
    items = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_sharp),
          label: "Gestisci Utenti"),
      BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts_rounded), label: "Profilo")
    ];
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
