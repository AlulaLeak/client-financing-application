import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_client_homewidget.dart';
import '../../constants/constants_documents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeAndProgressCircle extends StatelessWidget {
  WelcomeAndProgressCircle({super.key});

  late int idx;
  String? isNull;

  double _completedDocuments(snapshot) {
    var num = 0;
    for (var document in documents) {
      idx = documents.indexOf(document);
      if (idx > 0) {
        var valid = snapshot.data!.docs[0].get(document);
        if (valid != null) {
          num++;
        }
      }
    }
    double finalNum = num / (documents.length - 1);
    // print('finalNum: --------------- ${finalNum}');
    return finalNum;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello, \n ${context.watch<UserInformation>().name.toString()}!",
          style: const TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('uid', isEqualTo: context.watch<UserInformation>().uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {}
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 6,
                      value: _completedDocuments(snapshot),
                      backgroundColor: white,
                      valueColor: const AlwaysStoppedAnimation<Color>(green),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Column(
                      children: [
                        Text(
                          "${_completedDocuments(snapshot) * 100}%",
                          style: const TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Completed",
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ],
    );
  }
}
