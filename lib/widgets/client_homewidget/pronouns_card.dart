import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';
import '../../providers/step_provider.dart';

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

  Future<void> updateApplicationName() async {
    Provider.of<StepNumber>(context, listen: false).nextStep();
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({'pronouns': _character.toString()});
  }

  @override
  Widget build(BuildContext context) {
    String? docInfo = widget.user!.docs[0].get(widget.document.toString());
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
                : Icon(
                    Icons.circle_outlined,
                    color: Colors.grey.shade200,
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
            height: 90,
            decoration: BoxDecoration(
              gradient: context.watch<StepNumber>().step != widget.index &&
                      docInfo == null
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
                          const Color.fromARGB(255, 255, 255, 255),
                          docInfo == null
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
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: const Color.fromARGB(255, 0, 0, 0),
                      disabledColor: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Document ${widget.document}",
                          style: const TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 3),
                      Scrollbar(
                        thumbVisibility: docInfo == null,
                        child: SizedBox(
                            width: 200,
                            child: docInfo == null
                                ? SingleChildScrollView(
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
                                          const Text(
                                            "he/him",
                                            style: TextStyle(color: black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: "she/her",
                                            groupValue: _character,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _character = value;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "she/her",
                                            style: TextStyle(color: black),
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
                                          const Text(
                                            "they/them",
                                            style: TextStyle(color: black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: "other/prefer not to say",
                                            groupValue: _character,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _character = value;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "other/prefer not to say",
                                            style: TextStyle(color: black),
                                          ),
                                        ],
                                      ),
                                    ]))
                                : Text(
                                    docInfo,
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Column(children: [
                  docInfo == null
                      ? TextButton(
                          onPressed: () async {
                            await updateApplicationName();
                          },
                          child: const Text(
                            'Sumbit +',
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
          ),
        ),
      ],
    );
  }
}
