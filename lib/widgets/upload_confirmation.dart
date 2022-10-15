import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../providers/userinfo_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void uploadConfirmation(BuildContext context, String path, String fileName,
    String? fileType, Uint8List bytes) async {
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
          .update({fileType.toString(): fileName.toString()});

      final storage =
          FirebaseStorage.instanceFor(bucket: "gs://workingauth.appspot.com");
      final ref =
          storage.ref().child(user).child(fileType.toString()).child(fileName);
      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': path},
      );
      if (kIsWeb) {
        // ByteData bytes = await rootBundle.load(path);
        // Uint8List bytez = bytes.buffer.asUint8List();
        ref.putData(bytes, metadata);
      } else {
        ref.putFile(File(path), metadata);
      }
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Notice"),
    content: const Text(
        "Launching this missile will destroy the entire universe. Is this what you intended to do?"),
    actions: [
      cancelButton,
      uploadButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
