import 'package:deep_tald/features/authentication/presentation/screens/admin_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/gestione_pazienti.dart';
import 'package:deep_tald/features/chatbot/presentation/screens/chatbot.dart';
import 'package:deep_tald/features/authentication/presentation/screens/gestione_utenti.dart';
import 'package:deep_tald/features/authentication/presentation/screens/initial_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/medico_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/paziente_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:deep_tald/features/chatbot/presentation/screens/chatbot.dart';
import 'package:deep_tald/features/medico_ia/presentation/screens/usa_ia_page.dart';
import 'package:deep_tald/navbar/navbar.dart';
import 'package:get/get.dart';

import '../features/authentication/presentation/screens/profile_screen.dart';
import '../features/authentication/presentation/screens/login_screen.dart';

class Routes {
  // per aggiungere nuove routes aggiungi qui le stringhe corrispondenti.

  static String login = "/login";
  static String registration = "/registration";
  static String profile = "/profile";
  static String homeMedico = "/homeMedico";
  static String homePaziente = "/homePaziente";
  static String homeAdmin = "/homeAdmin";
  static String gestioneUtenti = "/gestioneUtenti";
  static String initialScreen = "/initialScreen";
  static String navbar = "/";
  static String chatbot = "/chatbot";
  static String medicoIa = "/medicoIa";
  static String gestionePazienti = "/gestionePazienti";

  //qui crea i getter
  static String getLoginRoute() => login;
  static String getProfileRoute() => profile;
  static String getRegistrationRoute() => registration;
  static String getHomeMedicoRoute() => homeMedico;
  static String getHomePazienteRoute() => homePaziente;
  static String getHomeAdminRoute() => homeAdmin;
  static String getInitialScren() => initialScreen;
  static String gestioneUtentiPage() => initialScreen;
  static String gestionePazientiPage() => gestionePazienti;
  static String getNavbar() => navbar;
  static String getChatBot() => chatbot;
  static String getMedicoIa() => medicoIa;

  // lista di tutte le routes
  static List<GetPage> routes = [
    GetPage(page: () => const Navbar(), name: navbar),
    GetPage(page: () => const InitialScreen(), name: initialScreen),
    GetPage(page: () => const LoginScreen(), name: login),
    GetPage(page: () => const ProfileScreen(), name: profile),
    GetPage(page: () => const RegistrationScreen(), name: registration),
    GetPage(page: () => const MedicoScreen(), name: homeMedico),
    GetPage(page: () => const PazienteScreen(), name: homePaziente),
    GetPage(page: () => const AdminPage(), name: homeAdmin),
    GetPage(page: () => const GestioneUtentiPage(), name: gestioneUtenti),
    GetPage(page: () => const ChatbotScreen(), name: chatbot),
    GetPage(page: () => const UsaIaScreen(), name: medicoIa),
    GetPage(page: () => const GestionePazientiPage(), name: gestionePazienti),
    //ad ogni pagina corrisponde un GetPage
  ];
}
