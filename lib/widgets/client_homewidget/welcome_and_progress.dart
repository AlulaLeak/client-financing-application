import 'package:flutter/material.dart';
import '../../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_client_homewidget.dart';

class WelcomeAndProgressCircle extends StatelessWidget {
  const WelcomeAndProgressCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello, \n ${context.watch<UserInformation>().name.toString()}!",
          style: const TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: const CircularProgressIndicator.adaptive(
            strokeWidth: 6,
            value: 0.7,
            backgroundColor: white,
            valueColor: AlwaysStoppedAnimation<Color>(green),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Column(
            children: const [
              Text(
                "70%",
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Completed",
                style: TextStyle(
                  color: white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
