import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/step_provider.dart';
import 'dart:io';

Future<void> uploadConfirmation(
  BuildContext context,
  String fileName,
  String? fileType,
  Uint8List bytes,
  String filePath,
) async {
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
      Provider.of<StepNumber>(context, listen: false).nextStep();
      FirebaseFirestore.instance
          .collection('users')
          .doc(context.read<UserInformation>().uid)
          .update({fileType.toString(): fileName.toString()});

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
        "Launching this missile will destroy the entire universe. Is this what you intended to do?"),
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
