import 'package:flutter/material.dart';
import '../../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_client_homewidget.dart';
import '../../constants/constants_documents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './picture_slider.dart';

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
        if (valid != null && valid != false && valid.runtimeType != int) {
          num++;
        }
      }
    }
    double finalNum = num / (documents.length - 2);
    return finalNum;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where('uid', isEqualTo: context.watch<UserInformation>().uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "Hello, \n ${context.watch<UserInformation>().name.toString()}!",
                  style: const TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 110,
                ),
              ]),
              const SizedBox(
                height: 30,
              ),
              const PictureSlider(),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "You are almost done \n with your application!",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white70,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularProgressIndicator.adaptive(
                          strokeWidth: 6,
                          value: _completedDocuments(snapshot),
                          backgroundColor: white,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(green),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Text(
                          "${(_completedDocuments(snapshot) * 100).toInt()} %",
                          style: const TextStyle(
                            color: white,
                            fontSize: 20,
                          ),
                        ),
                      ]),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
