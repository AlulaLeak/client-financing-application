import 'package:flutter/material.dart';
import '../../config/utils.dart';

class TrustedByCard extends StatelessWidget {
  const TrustedByCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 5,
            offset: const Offset(0, 7),
          ),
        ],
        color: white,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💙 Fitur Menarik',
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: secondary,
                          child: const Text(
                            '🏆',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Capaian',
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Positioned(
                      left: 33,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: red,
                        child: Text(
                          '1',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey[200],
                          child: const Text(
                            '🎁',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Ajak Teman',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Positioned(
                      left: 46,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '1',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: secondary,
                          child: const Text(
                            '🤔',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Insight\nKamu',
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const Positioned(
                      left: 52,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: red,
                        child: Text(
                          '1',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: secondary,
                      child: const Text(
                        '🧾',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      'Bayar\nTagihan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
