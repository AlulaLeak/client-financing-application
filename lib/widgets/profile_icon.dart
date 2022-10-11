import 'package:flutter/material.dart';
import 'package:workingauth/pages/profile_screen.dart';
import '../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const Profile(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
        child: Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                context.watch<UserInformation>().photoUrl.toString()),
          ),
        ));
  }
}
