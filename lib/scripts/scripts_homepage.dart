import 'package:flutter/material.dart';

slider(images, pagePosition, active) {
  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 121, 94, 72)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: Colors.white,
    ),
    child: Text(
        pagePosition == 1
            ? 'repudiandae fuga? Ipsa laudantium molestias eos sapiente officiis modisapiente officiis modi.'
            : 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mmolestiae quas vel sint commodi',
        style: const TextStyle(
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
