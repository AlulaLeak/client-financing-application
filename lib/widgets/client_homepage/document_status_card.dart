import 'package:flutter/material.dart';
import '../../config/utils.dart';

class DocumentStatusCard extends StatelessWidget {
  const DocumentStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        height: 350.0,
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
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext ctxt, int index) {
              if (index == 0) {
                return const Text(
                  '🗓 Performa Bulan Ini',
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              if (index % 2 != 0) {
                return const SizedBox(
                  height: 16,
                );
              }
              return Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 15,
                ),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: secondary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("Kamu udah keluarin",
                            style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 2,
                        ),
                        Text("Rp89rb",
                            style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Yuk, Bikin budget biar enggak overspend!",
                            style: TextStyle(
                                color: grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '+ Buat Budget',
                            style: TextStyle(
                              color: primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
