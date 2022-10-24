import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

Future<void> uploadConfirmation(BuildContext context, String fileName,
    String? fileType, Uint8List bytes, String filePath, String? docInfo) async {
  final user =
      Provider.of<UserInformation>(context, listen: false).uid.toString();
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget uploadButton = TextButton(
    child: const Text("Upload file"),
    onPressed: () async {
      FirebaseFirestore.instance
          .collection('users')
          .doc(context.read<UserInformation>().uid)
          .update({
        fileType.toString(): fileName.toString(),
        'step': FieldValue.increment(docInfo == null ? 1 : 0)
      });

      final storage =
          FirebaseStorage.instanceFor(bucket: "gs://workingauth.appspot.com");
      final ref =
          storage.ref().child(user).child(fileType.toString()).child(fileName);
      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': filePath},
      );
      if (kIsWeb) {
        ref.putData(bytes);
      } else {
        ref.putFile(File(filePath), metadata);
      }

      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text("Notice"),
    content: const Text(
        "Is this the file that you wish to upload? You may also change your chosen file before your final confirmation."),
    actions: [
      cancelButton,
      uploadButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
