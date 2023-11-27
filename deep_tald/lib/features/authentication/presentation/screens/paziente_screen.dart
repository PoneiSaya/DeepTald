import 'package:deep_tald/features/authentication/presentation/widget/Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class PazienteScreen extends StatefulWidget {
  const PazienteScreen({Key? key}) : super(key: key);

  @override
  State<PazienteScreen> createState() => _PazienteScreenState();
}

class _PazienteScreenState extends State<PazienteScreen> {
  final int currentPageIndex = 0;

  final AuthController _controller = Get.find<AuthController>();

  late String nome;
  late String cognome;

  @override
  Widget build(BuildContext context) {
    nome = _controller.getNome();
    cognome = _controller.getCognome();
    return MaterialApp(
      home: Scaffold(
        //CI STA LA NAVIGATION BAR QUI GIUSTO PER PROVARE
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {},
          indicatorColor: Colors.blue,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.notifications_sharp)),
              label: 'Notifiche',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.man),
              ),
              label: 'Profilo',
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: //padding sopra e a sinistra
                  const EdgeInsets.only(left: 30, top: 30),
              child: Text(
                'Ciao $nome $cognome!  \u{1F44B}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  CardDeepTald(
                    'assets/images/mindfullness.png',
                    'Parla con Bob!',
                    'Inizia',
                    () {
                      // ...
                    },
                  ),
                  CardDeepTald(
                    'assets/images/gestire.png',
                    'Controlla il tuo Andamento!',
                    'Controlla',
                    () {
                      // ...
                    },
                  ),
                  CardDeepTald(
                    'assets/images/gestire.png',
                    'Prova Logout!',
                    'LogOut',
                    //logout
                    () {
                      _controller.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
