import 'package:flutter/material.dart';
import './welcome_and_progress.dart';
import 'document_cardlist.dart';
import '../../constants/constants_client_homewidget.dart';

class ClientHomeWidget extends StatelessWidget {
  const ClientHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: primary,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/black-background.jpeg"),
                repeat: ImageRepeat.repeat),
          ),
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
      ),
    );
  }
}
