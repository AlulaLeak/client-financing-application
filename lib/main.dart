import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workingauth/pages/auth_page.dart';
import 'package:workingauth/pages/profile_screen.dart';
import 'package:workingauth/providers/pronoun_provider.dart';
import 'package:workingauth/providers/step_provider.dart';
import './config/firebase_options.dart';
import 'package:provider/provider.dart';
import './providers/bottomnav_provider.dart';
import './providers/userinfo_provider.dart';
import './providers/file_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // WidgetsBinding.instance.addPostFrameCallback((_) {
  // });

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BottomNavSelect()),
    ChangeNotifierProvider(create: (_) => UserInformation()),
    ChangeNotifierProvider(create: (_) => FileToUpload()),
    ChangeNotifierProvider(create: (_) => StepNumber()),
    ChangeNotifierProvider(create: (_) => SelectedPronoun()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        backgroundColor: const Color(0xFF0F0F1E),
      ),
      routes: {
        '/': (context) => const Auth(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
