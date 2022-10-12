import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:file_picker/file_picker.dart';
import '../upload_confirmation.dart';

class DocumentCard extends StatefulWidget {
  DocumentCard({Key? key, this.index = 0}) : super(key: key);

  final int index;

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  String _path = '';
  String _fileName = '';

  Future<void> _setFile(String filePath, String fileName) async {
    setState(() {
      _path = filePath;
      _fileName = fileName;
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
              widget.index % 3 == 0 + widget.index
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
              Text("Document ${widget.index}",
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
            widget.index % 3 == 0 + widget.index
                ? TextButton(
                    onPressed: () async {
                      var picked = await FilePicker.platform.pickFiles();
                      if (picked != null) {
                        _setFile(picked.files.single.path!,
                            picked.files.single.name);
                        uploadConfirmation(context, _path, _fileName);
                      }
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
                    onPressed: () {
                      print('Pressed!!');
                    },
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