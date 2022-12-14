import 'package:flutter/material.dart';
import 'package:workingauth/providers/pronoun_provider.dart';
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
  String name = '';
  final db = FirebaseFirestore.instance;

  Future<void> updateApplicationPronoun() async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({
      'pronouns': Provider.of<SelectedPronoun>(context, listen: false).pronoun,
      'step': FieldValue.increment(1),
    });
  }

  Future<void> editApplicationPronoun(onSuccess) async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({
      'pronouns': Provider.of<SelectedPronoun>(context, listen: false).pronoun,
    }).then((value) => onSuccess.call());
  }

  List<String> pronounList = [
    'he/him',
    'she/her',
    'they/them',
    'other/prefer not to say',
    'sample'
  ];

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
            const SizedBox(
              height: 80,
              child: VerticalDivider(
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
              color: primary.withOpacity(0.75),
              borderRadius: const BorderRadius.all(Radius.circular(1.0)),
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
                        controller: ScrollController(initialScrollOffset: 0),
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
                                            child: Row(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Radio<String>(
                                                      fillColor:
                                                          MaterialStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                                      Colors
                                                                          .grey),
                                                      value: "he/him",
                                                      groupValue: context
                                                          .watch<
                                                              SelectedPronoun>()
                                                          .pronoun,
                                                      onChanged:
                                                          (String? value) {
                                                        context
                                                            .read<
                                                                SelectedPronoun>()
                                                            .updatePronoun(value
                                                                .toString());
                                                      },
                                                    ),
                                                    Text(
                                                      "he/him",
                                                      style: TextStyle(
                                                          color: step ==
                                                                  widget.index
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
                                                      groupValue: context
                                                          .watch<
                                                              SelectedPronoun>()
                                                          .pronoun,
                                                      onChanged:
                                                          (String? value) {
                                                        context
                                                            .read<
                                                                SelectedPronoun>()
                                                            .updatePronoun(value
                                                                .toString());
                                                      },
                                                    ),
                                                    Text(
                                                      "she/her",
                                                      style: TextStyle(
                                                          color: step ==
                                                                  widget.index
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
                                                      value: "they/them",
                                                      groupValue: context
                                                          .watch<
                                                              SelectedPronoun>()
                                                          .pronoun,
                                                      onChanged:
                                                          (String? value) {
                                                        context
                                                            .read<
                                                                SelectedPronoun>()
                                                            .updatePronoun(value
                                                                .toString());
                                                      },
                                                    ),
                                                    Text(
                                                      "they/them",
                                                      style: TextStyle(
                                                          color: step ==
                                                                  widget.index
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
                                                      value:
                                                          "other/prefer not to say",
                                                      groupValue: context
                                                          .watch<
                                                              SelectedPronoun>()
                                                          .pronoun,
                                                      onChanged:
                                                          (String? value) {
                                                        context
                                                            .read<
                                                                SelectedPronoun>()
                                                            .updatePronoun(value
                                                                .toString());
                                                      },
                                                    ),
                                                    Text(
                                                      "other/prefer not to say",
                                                      style: TextStyle(
                                                          color: step ==
                                                                  widget.index
                                                              ? white
                                                              : grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
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
                                          margin:
                                              const EdgeInsets.only(top: 45),
                                          child: TextButton(
                                            onPressed: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'Choose your pronoun:'),
                                                content: SizedBox(
                                                  width: 400,
                                                  height: 300,
                                                  child: GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 1,
                                                        childAspectRatio: 6,
                                                      ),
                                                      itemCount:
                                                          pronounList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Row(
                                                          children: [
                                                            Radio<String>(
                                                              value:
                                                                  pronounList[
                                                                      index],
                                                              groupValue: context
                                                                  .watch<
                                                                      SelectedPronoun>()
                                                                  .pronoun,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                context
                                                                    .read<
                                                                        SelectedPronoun>()
                                                                    .updatePronoun(
                                                                        value
                                                                            .toString());
                                                              },
                                                            ),
                                                            Text(
                                                              pronounList[
                                                                  index],
                                                              style:
                                                                  const TextStyle(
                                                                      color:
                                                                          white),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await editApplicationPronoun(
                                                          () {
                                                        Navigator.pop(
                                                            context, 'OK');
                                                      });
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: const Text('[Edit]'),
                                          ))
                                    ],
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
