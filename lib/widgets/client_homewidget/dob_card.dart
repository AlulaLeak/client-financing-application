import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/userinfo_provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

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
  // DateTime _selectedDate = DateTime.now();

  Future<void> updateDateOfBirth() async {
    await db
        .collection("users")
        .doc(Provider.of<UserInformation>(context, listen: false).uid)
        .update({'date_of_birth': _selectedDate.toString()});
  }

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
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'
      });
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
              SizedBox(
                  width: 200,
                  child: widget.user!.docs[0].get(widget.document.toString()) ==
                          null
                      ? Center(
                          child: OutlinedButton(
                            onPressed: () {
                              _restorableDatePickerRouteFuture.present();
                            },
                            child: const Text('Open Date Picker'),
                          ),
                        )
                      : Text(
                          widget.user!.docs[0].get(widget.document.toString()),
                          style: const TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ))
            ],
          ),
          const Spacer(),
          Column(children: [
            widget.user!.docs[0].get(widget.document.toString()) == null
                ? OutlinedButton(
                    onPressed: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    child: const Text(
                      'Pick Date +',
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


// TextButton(
//                     onPressed: () async {
//                       await updateDateOfBirth();
//                     },
//                     child: const Text(
//                       'Sumbit +',
//                       style: TextStyle(
//                         color: primary,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )