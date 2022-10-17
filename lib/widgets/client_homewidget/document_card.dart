import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:file_picker/file_picker.dart';
import '../upload_confirmation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String _fileName = '';
  String _filePath = '';
  late Uint8List _bytes;

  Future<void> _setFile(
    String fileName,
    String? filePath,
    Uint8List? bytes,
  ) async {
    setState(() {
      _fileName = fileName;
      _filePath = filePath ?? '';
      _bytes = bytes ?? Uint8List(0);
    });
  }

  Future myAsyncMethod(setFile, VoidCallback onSuccess) async {
    final picked = await FilePicker.platform
        .pickFiles(type: FileType.any, withReadStream: true);
    if (picked != null) {
      if (kIsWeb) {
        await _setFile(
          picked.files.single.name,
          '',
          picked.files.single.bytes,
        ).then((value) => onSuccess.call());
      } else {
        await _setFile(
          picked.files.single.name,
          picked.files.single.path,
          Uint8List(0),
        ).then((value) => onSuccess.call());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 6, top: 20),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              widget.user!.docs[0].get(widget.document.toString()) == null
                  ? white
                  : const Color.fromARGB(255, 162, 255, 167)
            ],
            begin: Alignment.centerRight,
            end: const Alignment(0.005, 0.0),
            tileMode: TileMode.clamp),
        borderRadius: const BorderRadius.all(Radius.circular(1.0)),
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
                    onPressed: () async {
                      myAsyncMethod(_setFile, () async {
                        if (kIsWeb) {
                          await uploadConfirmation(context, _fileName,
                              widget.document, _bytes, _filePath);
                        } else {
                          await uploadConfirmation(context, _fileName,
                              widget.document, _bytes, _filePath);
                        }
                      });
                    },
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
