import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    const providerConfigs = [EmailProviderConfiguration()];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Profile'),
        ),
        body: ProfileScreen(providerConfigs: providerConfigs, actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ]));
  }
}
