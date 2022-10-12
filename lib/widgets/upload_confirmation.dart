import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

void uploadConfirmation(BuildContext context, path, fileName) async {
  Widget remindButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {},
  );
  Widget cancelButton = TextButton(
    child: const Text("Remind me later"),
    onPressed: () {},
  );
  Widget launchButton = TextButton(
    child: const Text("Launch missile"),
    onPressed: () async {
      final UploadTask uploadTask;
      final storage =
          FirebaseStorage.instanceFor(bucket: "gs://workingauth.appspot.com");
      final ref = storage.ref().child(fileName);
      final metadata = SettableMetadata(
        // contentType: 'application/pdf',
        contentType: 'image/png',
        customMetadata: {'picked-file-path': path},
      );
      if (kIsWeb) {
        ByteData bytes = await rootBundle.load(path);
        Uint8List bytez = bytes.buffer.asUint8List();
        ref.putData(bytez, metadata);
      } else {
        ref.putFile(File(path), metadata);
      }
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Notice"),
    content: const Text(
        "Launching this missile will destroy the entire universe. Is this what you intended to do?"),
    actions: [
      remindButton,
      cancelButton,
      launchButton,
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
