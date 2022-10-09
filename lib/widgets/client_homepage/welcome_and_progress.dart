import 'package:flutter/material.dart';
import '../../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';
import '../../config/utils.dart';

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
        const CircleAvatar(
          radius: 20,
          backgroundColor: white,
        ),
      ],
    );
  }
}
