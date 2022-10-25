import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';

class DateOfBirthCard extends StatefulWidget {
  const DateOfBirthCard(
      {Key? key, this.index = 0, this.document, this.user, this.restorationId})
      : super(key: key);

  final int index;
  final String? document;
  final QuerySnapshot<Object?>? user;
  final String? restorationId;

  @override
  State<DateOfBirthCard> createState() => _DateOfBirthCardState();
}

class _DateOfBirthCardState extends State<DateOfBirthCard>
    with RestorationMixin {
  TextEditingController nameController = TextEditingController();
  String name = '';
  final db = FirebaseFirestore.instance;

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1920),
          lastDate: DateTime(DateTime.now().year),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  Future<void> _selectDate(DateTime? newSelectedDate) async {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
      await db
          .collection("users")
          .doc(Provider.of<UserInformation>(context, listen: false).uid)
          .update({
        'date_of_birth':
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
        'step': FieldValue.increment(
            widget.user!.docs[0].get(widget.document.toString()) == null
                ? 1
                : 0),
      });
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
              decoration: BoxDecoration(
                color: primary.withOpacity(0.75),
                borderRadius: const BorderRadius.all(Radius.circular(1.0)),
              ),
              child: docInfo == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text("Please select your date of birth:",
                              style: TextStyle(
                                  color: step == widget.index ? white : grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          OutlinedButton(
                            onPressed: () {
                              _restorableDatePickerRouteFuture.present();
                            },
                            child: Text(
                              'Pick Date +',
                              style: TextStyle(
                                color: step == widget.index ? white : grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ])
                  : Column(
                      children: [
                        const Text("Your Date of birth is:",
                            style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(docInfo.toString(),
                                    style: const TextStyle(
                                        color: white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Stack(
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
                                      onPressed: () {
                                        _restorableDatePickerRouteFuture
                                            .present();
                                      },
                                      child: const Text('[Edit]'),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
        ),
      ],
    );
  }
}
