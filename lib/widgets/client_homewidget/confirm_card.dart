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
            SizedBox(
              height: collapsedIfCompleted(docInfo),
              child: const VerticalDivider(
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
                color: primary,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding:
                const EdgeInsets.only(left: 2, right: 16, top: 16, bottom: 16),
            margin: const EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              gradient: step != widget.index && docInfo == false
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
                          docInfo == false
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
                  children: const [
                    Text(
                        "By clicking 'Confirm', you are hereby aknowleging that all the information above is correct, and you are agreeing to sell you soul to the devil (jkjk.. maybe?).",
                        style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 3),
                  ],
                ),
                const Spacer(),
                Column(children: [
                  docInfo == false
                      ? TextButton(
                          onPressed: () async {
                            await updateConfirmation();
                          },
                          child: const Text(
                            'Confirm',
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



// TODO: add final card confirming if the person is ready to submit
// if they submit, then add the data to the database (add "completed" bool to db)
// and remove all the other cards and replace them with a "thank you for applying" card or something

// TODO: make it so the user cant submit until the last step is completed (grey out later cards and make them unclickable)
// TDOO: make it so the user can replace the old submitions with new ones (until they press the final submit)
// TODO: move checkmarks/circles to the right (or do w/e to make it look better)