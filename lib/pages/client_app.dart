import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/bottomnav_provider.dart';
import '../providers/userinfo_provider.dart';
import '../widgets/client_homewidget/client_homewidget.dart';
import '../widgets/side_menu.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/profile_icon.dart';

class ClientApp extends StatelessWidget {
  ClientApp({super.key});

  final List<Widget> _widgetOptions = <Widget>[
    const ClientHomeWidget(),
    const Center(
      child: Text('Client App Page 2'),
    ),
    const Center(
      child: Text('Client App Page 3'),
    ),
  ];

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db
          .collection("users")
          .where("uid", isEqualTo: context.read<UserInformation>().uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.docs.isEmpty) {
            final user = <String, dynamic>{
              "uid": context.read<UserInformation>().uid,
              "name": context.read<UserInformation>().name,
              "email": context.read<UserInformation>().email,
              "photoUrl": context.read<UserInformation>().photoUrl,
              "created_at": DateTime.now(),
            };
            db.collection("users").add(user);
          }
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text("Finance Your Truck"),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const ProfileIcon(),
                ),
              ],
            ),
            body: _widgetOptions
                .elementAt(context.watch<BottomNavSelect>().selectedIndex),
            drawer: const SideMenu(),
            bottomNavigationBar: const BottomNavBar());
      },
    );
  }
}
