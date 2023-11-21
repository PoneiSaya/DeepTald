import 'package:deep_tald/features/authentication/model/entities/paziente.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'package:deep_tald/repository/paziente_repository.dart';

class RegistrationScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final PazienteRepostitory pazienteRepository = Get
      .find(); // Aggiungi questa linea per ottenere l'istanza di PazienteRepository

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: cognomeController,
              decoration: InputDecoration(labelText: 'Cognome'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                String nome = nomeController.text.trim();
                String cognome = cognomeController.text.trim();

                if (email.isNotEmpty &&
                    password.isNotEmpty &&
                    nome.isNotEmpty &&
                    cognome.isNotEmpty) {
                  // Crea un'istanza di Paziente
                  /*  Paziente paziente = Paziente(
                    nome: nome,
                    cognome: cognome,
                    codFiscale:
                        '', // Aggiungi un valore appropriato se necessario
                    email: email,
                    password: password,
                    dataDiNascita: DateTime
                        .now(), // Aggiungi una data di nascita appropriata
                  );

                  // Chiamare il metodo di registrazione del repository Paziente
                  await pazienteRepository.createPaziente(paziente);*/

                  // Puoi implementare la logica di navigazione o feedback all'utente qui
                } else {
                  Get.snackbar(
                    'Campi vuoti',
                    'Compila tutti i campi',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}
