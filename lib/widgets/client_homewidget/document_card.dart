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
    String? docInfo = widget.user!.docs[0].get(widget.document.toString());
    int step = widget.user!.docs[0].get('step');

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
                : step == widget.index
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
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  docInfo == null
                      ? Text("Please upload your ${widget.document}:",
                          style: TextStyle(
                              color: step == widget.index ? white : grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))
                      : Text('Your ${widget.document}:',
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
                                        color: step == widget.index
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
                        widget.user!.docs[0].get(widget.document.toString()) ==
                                null
                            ? OutlinedButton(
                                onPressed: () async {
                                  myAsyncMethod(_setFile, () async {
                                    if (kIsWeb) {
                                      await uploadConfirmation(
                                          context,
                                          _fileName,
                                          widget.document,
                                          _bytes,
                                          _filePath,
                                          docInfo);
                                    } else {
                                      await uploadConfirmation(
                                          context,
                                          _fileName,
                                          widget.document,
                                          _bytes,
                                          _filePath,
                                          docInfo);
                                    }
                                  });
                                },
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                    color: step == widget.index ? white : grey,
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
                                      onPressed: () async {
                                        myAsyncMethod(_setFile, () async {
                                          if (kIsWeb) {
                                            await uploadConfirmation(
                                                context,
                                                _fileName,
                                                widget.document,
                                                _bytes,
                                                _filePath,
                                                docInfo);
                                          } else {
                                            await uploadConfirmation(
                                                context,
                                                _fileName,
                                                widget.document,
                                                _bytes,
                                                _filePath,
                                                docInfo);
                                          }
                                        });
                                      },
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
        ),
      ],
    );
  }
}
