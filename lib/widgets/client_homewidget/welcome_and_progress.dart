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

  String _progressStatement(completedDocuments) {
    if (completedDocuments == 0) {
      return "Please start your \n application!";
    } else if (completedDocuments > 0 && completedDocuments < 20) {
      return "Way to get started! \n Complete your \n application below.";
    } else if (completedDocuments > 20 && completedDocuments < 50) {
      return "That's good progress! \n Complete your \n application below.";
    } else if (completedDocuments == 50) {
      return "You're half way there! \n Complete your \n application below.";
    } else if (completedDocuments > 50 && completedDocuments < 100) {
      return "You are almost done \n with your application!";
    } else {
      return ".......Done!";
    }
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
                  Text(
                    _progressStatement(_completedDocuments(snapshot) * 100),
                    style: const TextStyle(
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
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
