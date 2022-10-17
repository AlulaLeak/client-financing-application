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
    ClientHomeWidget(),
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
    Stream<void> foo() {
      return db
          .collection("users")
          .where("uid", isEqualTo: context.read<UserInformation>().uid)
          .snapshots();
    }

    Future bar(snapshot) async {
      if (snapshot.hasData) {
        if (snapshot.data?.docs.isEmpty) {
          final user = <String, dynamic>{
            "uid": context.read<UserInformation>().uid,
            "name": context.read<UserInformation>().name,
            "email": context.read<UserInformation>().email,
            "photoUrl": context.read<UserInformation>().photoUrl,
            "doc_1": null,
            "doc_2": null,
            "doc_3": null,
            "doc_4": null,
            "doc_5": null,
            "application_name": null,
            "created_at": DateTime.now(),
          };
          db
              .collection("users")
              .doc(context.read<UserInformation>().uid)
              .set(user);
        }
      }
    }

    return StreamBuilder(
      stream: foo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return FutureBuilder(
          future: bar(snapshot),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Financing Application"),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications)),
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
      },
    );
  }
}
