import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:file_picker/file_picker.dart';
import '../upload_confirmation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(
      BuildContext context, setFile, VoidCallback onSuccess) async {
    var picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      await setFile(picked.files.single.path!, picked.files.single.name,
          picked.files.single.bytes);
      onSuccess.call();
    }
  }
}

class DocumentCard extends StatefulWidget {
  const DocumentCard({Key? key, this.index = 0, this.document, this.user})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  String _path = '';
  String _fileName = '';
  late Uint8List _bytes;

  Future<void> _setFile(
      String filePath, String fileName, Uint8List bytes) async {
    setState(() {
      _path = filePath;
      _fileName = fileName;
      _bytes = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 6, top: 20),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(61, 209, 209, 209),
            offset: Offset(3.0, 2.0),
          ),
        ],
        gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              widget.user!.docs[0].get(widget.document.toString()) == null
                  ? white
                  : const Color.fromARGB(255, 222, 245, 223)
            ],
            begin: Alignment.centerRight,
            end: const Alignment(0.005, 0.0),
            tileMode: TileMode.clamp),
        color: widget.index % 3 == 0 + widget.index
            ? white
            : const Color.fromARGB(255, 222, 245, 223),
        border: Border.all(width: 2, color: secondary),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Document ${widget.document}",
                  style: const TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 3),
              const SizedBox(
                width: 200,
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur adipisicing",
                  style: TextStyle(
                      color: grey, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(children: [
            widget.user!.docs[0].get(widget.document.toString()) == null
                ? TextButton(
                    onPressed: () => const MyCustomClass()
                        .myAsyncMethod(context, _setFile, () {
                      uploadConfirmation(
                          context, _path, _fileName, widget.document, _bytes);
                    }),
                    child: const Text(
                      'Upload +',
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Complete!',
                      style: TextStyle(
                        color: green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ])
        ],
      ),
    );
  }
}

// var picked = await FilePicker.platform.pickFiles();
// if (picked != null) {
//   _setFile(picked.files.single.path!,
//       picked.files.single.name);
//   uploadConfirmation(
//       context, _path, _fileName, widget.document);
// }
