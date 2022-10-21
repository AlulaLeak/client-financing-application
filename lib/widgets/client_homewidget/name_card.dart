import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_client_homewidget.dart';
import '../../providers/userinfo_provider.dart';

class NameCard extends StatefulWidget {
  const NameCard({Key? key, this.index = 0, this.document, this.user})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;

  @override
  State<NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  TextEditingController nameController = TextEditingController();
  String name = '';
  final db = FirebaseFirestore.instance;
  bool _validate = false;

  Future<void> updateApplicationName() async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({
      'application_name': nameController.text,
      'step': FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    String? docInfo = widget.user!.docs[0].get(widget.document.toString());
    int step = widget.user!.docs[0].get('step');
    final ButtonStyle submitButtonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              height: collapsedIfCompleted(docInfo),
              child: const VerticalDivider(
                color: primary,
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
            decoration: BoxDecoration(
              gradient: step != widget.index && docInfo == null
                  ? const LinearGradient(
                      colors: [
                          Color.fromARGB(255, 114, 114, 114),
                          Color.fromARGB(255, 114, 114, 114),
                        ],
                      begin: Alignment.centerRight,
                      end: Alignment(0.005, 0.0),
                      tileMode: TileMode.clamp)
                  : LinearGradient(
                      colors: [
                          primary,
                          docInfo == null
                              ? primary
                              : const Color.fromARGB(255, 162, 255, 167)
                        ],
                      begin: Alignment.centerRight,
                      end: const Alignment(0.005, 0.0),
                      tileMode: TileMode.clamp),
              borderRadius: const BorderRadius.all(Radius.circular(1.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Please enter your name here:",
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 200,
                              child: docInfo == null
                                  ? TextField(
                                      controller: nameController,
                                      obscureText: false,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 114, 114, 114),
                                              width: 1),
                                        ),
                                        hintText: _validate
                                            ? 'Value Can\'t Be Empty'
                                            : 'Full Name',
                                        hintStyle: TextStyle(
                                            color: _validate
                                                ? Colors.red
                                                : Colors.grey),
                                      ),
                                    )
                                  : Text(
                                      docInfo,
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                          const SizedBox(width: 15),
                          docInfo == null
                              ? ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      nameController.text == ""
                                          ? _validate = true
                                          : _validate = false;
                                    });
                                    if (nameController.text != "") {
                                      await updateApplicationName();
                                    }
                                  },
                                  child: const Text('Submit'),
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
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
