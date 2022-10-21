import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import './document_card.dart';
import '../../constants/constants_documents.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/client_homewidget/name_card.dart';
import '../../widgets/client_homewidget/pronouns_card.dart';
import '../../widgets/client_homewidget/dob_card.dart';
import '../../widgets/client_homewidget/confirm_card.dart';

class DocumentStatusCard extends StatelessWidget {
  const DocumentStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: context.watch<UserInformation>().uid)
            .snapshots(),
        builder: (context, snapshot) {
          int step = snapshot.data!.docs[0].get('step');
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.only(
                    left: 2, right: 16, top: 16, bottom: 16),
                height: (210 * documents.length).toDouble() -
                    (120 * step).toDouble(),
                color: primary,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const VerticalDivider(
                          thickness: 1,
                          color: Color(0xFFF6F4F4),
                        ),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isFocused =
                          snapshot.data!.docs[0].get('step') == index;
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Please continue to fill out\nthe following documents:',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: primary),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      } else if (documents[index] == 'date_of_birth') {
                        if (isFocused) {
                          return DateOfBirthCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return IgnorePointer(
                            child: DateOfBirthCard(
                                index: index,
                                document: documents[index],
                                user: snapshot.data),
                          );
                        }
                      } else if (documents[index] == 'application_name') {
                        if (isFocused) {
                          return NameCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return IgnorePointer(
                            child: NameCard(
                                index: index,
                                document: documents[index],
                                user: snapshot.data),
                          );
                        }
                      } else if (documents[index] == 'pronouns') {
                        if (isFocused) {
                          return PronounsCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return IgnorePointer(
                            child: PronounsCard(
                                index: index,
                                document: documents[index],
                                user: snapshot.data),
                          );
                        }
                      } else if (documents[index] == 'confirmed') {
                        if (isFocused) {
                          return ConfirmCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return IgnorePointer(
                            child: ConfirmCard(
                                index: index,
                                document: documents[index],
                                user: snapshot.data),
                          );
                        }
                      } else if (documents[index][0] == 'd') {
                        if (isFocused) {
                          return DocumentCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return IgnorePointer(
                            child: DocumentCard(
                                index: index,
                                document: documents[index],
                                user: snapshot.data),
                          );
                        }
                      } else {
                        return const Spacer();
                      }
                    }));
          } else {
            return const Text('Loading...');
          }
        });
  }
}
