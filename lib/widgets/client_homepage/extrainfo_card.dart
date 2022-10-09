import 'package:flutter/material.dart';
import '../../config/utils.dart';

class ExtraInfoCard extends StatelessWidget {
  const ExtraInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        color: Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Gimana sih cara pake Finku?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Text(
                'Pelajari bareng Fin-E!',
                style: TextStyle(
                  color: primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: primary,
                size: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
