import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';

class PronounsCard extends StatefulWidget {
  const PronounsCard({Key? key, this.index = 0, this.document, this.user})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;

  @override
  State<PronounsCard> createState() => _PronounsCardState();
}

class _PronounsCardState extends State<PronounsCard> {
  String? _character = "he/him";

  String name = '';
  final db = FirebaseFirestore.instance;

  Future<void> updateApplicationPronoun() async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({
      'pronouns': _character.toString(),
      'step': FieldValue.increment(1),
    });
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
            child: Row(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: const Color.fromARGB(255, 0, 0, 0),
                      disabledColor: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      docInfo == null
                          ? Text("Please select your pronouns:",
                              style: TextStyle(
                                  color: step == widget.index ? white : grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))
                          : const Text("Your pronouns are:",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                      const SizedBox(height: 7),
                      Scrollbar(
                        thumbVisibility: docInfo == null,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 200,
                                child: docInfo == null
                                    ? Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: docInfo == null
                                                    ? const Color.fromARGB(
                                                        255, 71, 71, 71)
                                                    : const Color.fromARGB(
                                                        255, 114, 114, 114))),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(children: <Widget>[
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: "he/him",
                                                    groupValue: _character,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _character = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "he/him",
                                                    style: TextStyle(
                                                        color:
                                                            step == widget.index
                                                                ? white
                                                                : grey),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    fillColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) =>
                                                                    Colors
                                                                        .grey),
                                                    value: "she/her",
                                                    groupValue: _character,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _character = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "she/her",
                                                    style: TextStyle(
                                                        color:
                                                            step == widget.index
                                                                ? white
                                                                : grey),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: "they/them",
                                                    groupValue: _character,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _character = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "they/them",
                                                    style: TextStyle(
                                                        color:
                                                            step == widget.index
                                                                ? white
                                                                : grey),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value:
                                                        "other/prefer not to say",
                                                    groupValue: _character,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _character = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "other/prefer not to say",
                                                    style: TextStyle(
                                                        color:
                                                            step == widget.index
                                                                ? white
                                                                : grey),
                                                  ),
                                                ],
                                              ),
                                            ])),
                                      )
                                    : Text(
                                        docInfo,
                                        style: const TextStyle(
                                            color: white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )),
                            const SizedBox(width: 10),
                            docInfo == null
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: step == widget.index
                                          ? Colors.blue
                                          : const Color.fromARGB(
                                              255, 94, 120, 139),
                                    ),
                                    onPressed: () async {
                                      await updateApplicationPronoun();
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
                        ),
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
