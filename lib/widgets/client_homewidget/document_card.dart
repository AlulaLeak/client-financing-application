import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DocumentCard extends StatelessWidget {
  const DocumentCard({Key? key, this.index = 0, this.document, this.user})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;

  @override
  Widget build(BuildContext context) {
    String? docInfo = user!.docs[0].get(document.toString());
    int step = user!.docs[0].get('step');
    void uploadFiles() async {
      final picked = await FilePicker.platform.pickFiles();
      if (picked != null) {
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
                .doc(user!.docs[0].get('uid'))
                .update({
              document.toString(): picked.files.single.name.toString(),
              'step': FieldValue.increment(docInfo == null ? 1 : 0)
            });

            final storage = FirebaseStorage.instanceFor(
                bucket: "gs://workingauth.appspot.com");
            final ref = storage
                .ref()
                .child(user!.docs[0].get('uid'))
                .child(document.toString())
                .child(picked.files.single.name);
            final metadata = SettableMetadata(
              customMetadata: {
                'picked-file-path': picked.files.single.path.toString()
              },
            );
            ref.putFile(File(picked.files.single.path.toString()), metadata);
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
    }

    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              height: collapsedIfCompleted(docInfo),
              child: const VerticalDivider(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            docInfo != null
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 35,
                  )
                : step == index
                    ? Icon(
                        Icons.add_circle,
                        color: Colors.grey.shade200,
                        size: 35,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        color: Color.fromARGB(255, 114, 114, 114),
                        size: 35,
                      ),
            SizedBox(
              height: collapsedIfCompleted(docInfo),
              child: const VerticalDivider(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 20),
            margin: const EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.all(Radius.circular(1.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                docInfo == null
                    ? Text("Please upload your $document:",
                        style: TextStyle(
                            color: step == index ? white : grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500))
                    : Text('Your $document:',
                        style: const TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: docInfo == null
                              ? Text(
                                  "Placeholder for an explanation of the file that needs to be uploaded here",
                                  style: TextStyle(
                                      color: step == index
                                          ? Colors.grey.shade300
                                          : grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  docInfo,
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(children: [
                      user!.docs[0].get(document.toString()) == null
                          ? OutlinedButton(
                              onPressed: uploadFiles,
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                  color: step == index ? white : grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                const Text(
                                  'Complete!',
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 45),
                                  child: TextButton(
                                    onPressed: uploadFiles,
                                    child: const Text('[Edit]'),
                                  ),
                                )
                              ],
                            ),
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
