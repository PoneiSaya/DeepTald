import 'package:deep_tald/features/authentication/presentation/screens/medico_screen.dart';
import 'package:deep_tald/features/authentication/presentation/screens/registration_screen.dart';
import 'package:get/get.dart';

import '../features/authentication/presentation/screens/profile_screen.dart';
import '../features/authentication/presentation/screens/home_screen.dart';
import '../features/authentication/presentation/screens/login_screen.dart';

class Routes {
  // per aggiungere nuove routes aggiungi qui le stringhe corrispondenti
  static String home = "/";
  static String login = "/login";
  static String registration = "/registration";
  static String profile = "/profile";
  static String medico = "/medico";

  //qui crea i getter
  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getProfileRoute() => profile;
  static String getRegistrationRoute() => registration;
  static String getMedicoRoute() => medico;

  // lista di tutte le routes
  static List<GetPage> routes = [
    GetPage(
        page: () => const HomeScreen(),
        name: home,
        transition: Transition.circularReveal),
    GetPage(page: () => const LoginScreen(), name: login),
    GetPage(page: () => const ProfileScreen(), name: profile),
    GetPage(page: () => RegistrationScreen(), name: registration),
    GetPage(page: () => const MedicoScreen(), name: medico),
    //ad ogni pagina corrisponde un GetPage
  ];
}
