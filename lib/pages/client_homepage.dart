import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/profile_icon.dart';
import '../providers/bottomnav_provider.dart';
import 'package:provider/provider.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomePage({super.key});

  final List<Widget> _widgetOptions = <Widget>[
    const Center(
      child: Text('Client Home Page 1'),
    ),
    const Center(
      child: Text('Client Home Page 2'),
    ),
    const Center(
      child: Text('Client Home Page 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Home Page'),
          actions: [
            const ProfileIcon(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: _widgetOptions
            .elementAt(context.watch<BottomNavSelect>().selectedIndex),
        drawer: const SideMenu(),
        bottomNavigationBar: const BottomNavBar());
  }
}
