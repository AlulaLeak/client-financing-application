import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workingauth/pages/client_app.dart';
import 'package:workingauth/pages/signin_page.dart';
import 'package:provider/provider.dart';
import '../providers/userinfo_provider.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return FutureBuilder(
              future: context
                  .read<UserInformation>()
                  .updateUserInfo(snapshot.data!),
              builder: (BuildContext context, AsyncSnapshot snap) {
                return const ClientApp();
              },
            );
          } else {
            return const SignInPage();
          }
        });
  }
}
