import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../widget/Button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PROFILO'),
        ),
        body: Container(color: const Color.fromARGB(255, 1, 27, 73)));
  }
}
