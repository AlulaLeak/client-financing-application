import 'package:flutter/material.dart';
import './picture_slider.dart';
import './welcome_and_progress.dart';
import './document_status_card.dart';
import './trustedby_card.dart';
import './extrainfo_card.dart';

import '../../config/utils.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Container(
                  height: 700,
                  color: scaffoldbg,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  children: const [
                    WelcomeAndProgressCircle(),
                    SizedBox(height: 20.0),
                    PictureSlider(),
                    SizedBox(height: 20.0),
                    DocumentStatusCard(),
                    SizedBox(height: 20.0),
                    TrustedByCard(),
                    SizedBox(height: 20.0),
                    ExtraInfoCard(),
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
