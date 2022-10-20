import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Color
// const scaffoldbg = Color.fromARGB(255, 255, 200, 255);
const scaffoldbg = Color.fromARGB(255, 0, 115, 209);
const black = Color.fromARGB(255, 0, 0, 0);
const grey = CupertinoColors.systemGrey;
const primary = Color.fromARGB(255, 20, 20, 20);
final secondary = Colors.grey[200]!;
const youngblue = Color.fromRGBO(223, 242, 254, 1);
final borderblue = Colors.blue[200]!;
const white = CupertinoColors.white;
const activetab = Color.fromRGBO(182, 215, 253, 1);
const green = Color.fromRGBO(82, 167, 111, 1);
const greenold = Color.fromRGBO(67, 138, 88, 1);
const greenbg = Color.fromRGBO(175, 227, 201, 1);
const textgreen = Color.fromRGBO(35, 78, 45, 1);
const red = Color.fromRGBO(232, 63, 51, 1);
const textpurple = Color.fromRGBO(61, 30, 90, 1);
const purplebg = Color.fromRGBO(233, 215, 229, 1);
const orange = CupertinoColors.systemOrange;
const cream = Color.fromRGBO(253, 235, 181, 1);
const textbrown = Color.fromRGBO(179, 126, 42, 1);

List<String> images = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
  "https://wallpaperaccess.com/full/2637581.jpg"
];

double collapsedIfCompleted(foo) {
  if (foo == null) {
    return 80;
  } else {
    return 40;
  }
}
