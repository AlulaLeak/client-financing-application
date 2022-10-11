import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import './document_card.dart';

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
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 12,
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
                return DocumentCard(index: index);
              }
            }));
  }
}
