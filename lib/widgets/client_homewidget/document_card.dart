import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({Key? key, this.index = 0}) : super(key: key);

  final int index;

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
              index % 3 == 0 + index
                  ? white
                  : const Color.fromARGB(255, 222, 245, 223)
            ],
            begin: Alignment.centerRight,
            end: const Alignment(0.005, 0.0),
            tileMode: TileMode.clamp),
        color: index % 3 == 0 + index
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
              Text("Document $index",
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
            index % 3 == 0 + index
                ? TextButton(
                    onPressed: () {
                      print('Pressed!!');
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
