import 'package:deep_tald/features/authentication/controllers/admin_controller.dart';
import 'package:deep_tald/features/authentication/presentation/widget/Button.dart';
import 'package:deep_tald/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCardMonitora extends StatefulWidget {
  late String nome, cognome;
  late String ruolo;
  String uid;

  UserCardMonitora(
      {super.key,
      required this.nome,
      required this.cognome,
      required this.ruolo,
      required this.uid});

  @override
  UserCardMonitoraState createState() => UserCardMonitoraState();
}

class UserCardMonitoraState extends State<UserCardMonitora> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Card(
        color: const Color.fromRGBO(191, 223, 225, 1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Image.asset(
                      "assets/images/patient2.png",
                      width: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${widget.nome} ${widget.cognome}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.rubik(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    print("QUI MI STAMPO UID = " + widget.uid);
                    Get.toNamed(Routes.getReportPage(),
                        parameters: {'uidPaziente': widget.uid});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF599BFF),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Report"),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
