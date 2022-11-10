import 'package:flutter/material.dart';
import './document_card.dart';
import '../../constants/constants_client_homewidget.dart';
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
          if (snapshot.hasData) {
            bool applicationIsCompleted =
                snapshot.data!.docs[0].get('confirmed');
            return ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 2000, minHeight: 56.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        applicationIsCompleted == false ? documents.length : 1,
                    itemBuilder: (BuildContext context, int index) {
                      bool isFocused =
                          snapshot.data!.docs[0].get('step') >= index;
                      if (applicationIsCompleted == false) {
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
                          return DateOfBirthCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else if (documents[index] == 'application_name') {
                          return NameCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else if (documents[index] == 'pronouns') {
                          return PronounsCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
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
                                    user: snapshot.data));
                          }
                        } else if (documents[index][0] == 'd') {
                          return DocumentCard(
                              index: index,
                              document: documents[index],
                              user: snapshot.data);
                        } else {
                          return const Spacer();
                        }
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const Text(
                              'Your Application is complete! Expect a call back next week or or however this business operates.',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        );
                      }
                    }));
          } else {
            return const Text('Loading...');
          }
        });
  }
}
