import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import './document_card.dart';
import '../../constants/constants_documents.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/client_homewidget/name_card.dart';

class DocumentStatusCard extends StatelessWidget {
  const DocumentStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        height: 1000.0,
        color: primary,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('uid', isEqualTo: context.watch<UserInformation>().uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return const Text(
                          ' Uploaded Documents 📄',
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              backgroundColor: primary),
                        );
                      } else if (documents[index] == 'application_name') {
                        return NameCard(
                            index: index,
                            document: documents[index],
                            user: snapshot.data);
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
