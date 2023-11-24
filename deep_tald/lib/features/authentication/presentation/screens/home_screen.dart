import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HOMEPAGE"),
        ),
        body: Container(
          color: Colors.blueAccent,
        ));
  }
}
