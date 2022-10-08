import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/profile_icon.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Home Page'),
          actions: const [
            ProfileIcon(),
          ],
        ),
        body: const Center(
          child: Text('Client Home Page'),
        ),
        drawer: const SideMenu(),
        bottomNavigationBar: const BottomNavBar());
  }
}
