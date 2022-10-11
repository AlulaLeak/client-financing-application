import 'package:flutter/material.dart';
import '../../constants/constants_client_homewidget.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({Key? key, this.index = 0}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.only(left: 14, right: 8, top: 11),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Document $index",
              style: const TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(
                width: 200,
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur adipisicing",
                  style: TextStyle(
                      color: grey, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 7),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: index % 3 == 0 + index
                      ? const Text(
                          'Upload +',
                          style: TextStyle(
                            color: primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Complete!',
                          style: TextStyle(
                            color: green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
