import 'package:flutter/material.dart';

slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 121, 94, 72)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: Colors.white,
    ),
    child: const Text(
        'Your Application is complete! Expect a call back next week or or however this business operates.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        )),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: const [
          Text('data'),
        ],
      ),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
