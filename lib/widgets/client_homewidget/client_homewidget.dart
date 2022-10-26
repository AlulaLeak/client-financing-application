import 'package:flutter/material.dart';
import './welcome_and_progress.dart';
import 'document_cardlist.dart';

class ClientHomeWidget extends StatelessWidget {
  const ClientHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/black-background.jpeg"),
                fit: BoxFit.fitHeight,
                repeat: ImageRepeat.repeat)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 50),
                child: Column(
                  children: [
                    WelcomeAndProgressCircle(),
                    const SizedBox(height: 20.0),
                    const DocumentStatusCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
