import 'package:deep_tald/navbar/navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final navbarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: navbarController.tabIndex,
          children: navbarController.pagine,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF599BFF),
          currentIndex: navbarController.tabIndex,
          onTap: navbarController.changeTabIndex,
          items: navbarController.items,
        ),
      );
    });
  }
}

_bottombarItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
