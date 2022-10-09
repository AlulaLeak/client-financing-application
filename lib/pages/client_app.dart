import 'package:flutter/material.dart';
import 'package:workingauth/widgets/client_homepage/client_homepage.dart';
import '../widgets/side_menu.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/profile_icon.dart';
import '../providers/bottomnav_provider.dart';
import 'package:provider/provider.dart';

class ClientApp extends StatelessWidget {
  ClientApp({super.key});

  final List<Widget> _widgetOptions = <Widget>[
    const ClientHomePage(),
    const Center(
      child: Text('Client App Page 2'),
    ),
    const Center(
      child: Text('Client App Page 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client App'),
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
