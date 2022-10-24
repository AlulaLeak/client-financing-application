import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';

class ConfirmCard extends StatefulWidget {
  const ConfirmCard({Key? key, this.index = 0, this.document, this.user})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;

  @override
  State<ConfirmCard> createState() => _ConfirmCardState();
}

class _ConfirmCardState extends State<ConfirmCard> {
  TextEditingController nameController = TextEditingController();
  final db = FirebaseFirestore.instance;

  Future<void> updateConfirmation() async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({
      'confirmed': true,
      'step': FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    bool docInfo = widget.user!.docs[0].get(widget.document.toString());
    int step = widget.user!.docs[0].get('step');

    return Row(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 100,
              child: VerticalDivider(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            docInfo != false
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 35,
                  )
                : step == widget.index
                    ? Icon(
                        Icons.auto_awesome_outlined,
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
                color: primary,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
              padding: const EdgeInsets.only(left: 10, top: 20),
              margin: const EdgeInsets.only(left: 10),
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.all(Radius.circular(1.0)),
              ),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Please Confirm:",
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 300,
                      child: Text(
                          "By clicking 'Confirm', you are hereby acknowleging that all the information above is correct, and your are agreeing to sell you soul to the devil (jkjk.. maybe?).",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),
                    docInfo == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                icon:
                                    const Icon(Icons.cancel_presentation_sharp),
                                onPressed: () async {
                                  await updateConfirmation();
                                },
                                label: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.check),
                                onPressed: () async {
                                  await updateConfirmation();
                                },
                                label: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
              )),
        ),
      ],
    );
  }
}
