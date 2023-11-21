import 'package:flutter/material.dart';

class Registrazione extends StatefulWidget {
  @override
  _RegistrazioneState createState() => _RegistrazioneState();
}

class _RegistrazioneState extends State<Registrazione> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione Utente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Cognome'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12.0),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Aggiungi qui la tua logica di registrazione dell'utente
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;

                // Chiamare la tua logica di registrazione (es. metodo di AuthController)
                // Esempio: authController.registerWithEmailAndPassword(email, password, firstName, lastName);

                // Puoi implementare la logica di navigazione o feedback all'utente qui
              },
              child: Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}
