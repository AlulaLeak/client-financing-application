import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import './document_card.dart';
import '../../constants/constants_documents.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentStatusCard extends StatelessWidget {
  const DocumentStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        height: 350.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 7),
            ),
          ],
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('uid', isEqualTo: context.watch<UserInformation>().uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return const Text(
                          '- Uploaded Documents 📄',
                          style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              backgroundColor: white),
                        );
                      } else {
                        return DocumentCard(
                            index: index,
                            document: documents[index],
                            user: snapshot.data);
                      }
                    });
              } else {
                return const Text('No data...');
              }
            }));
  }
}
