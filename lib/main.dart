import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workingauth/auth/auth_wrapper.dart';
import 'package:workingauth/pages/profile_screen.dart';
import './config/firebase_options.dart';
import 'package:provider/provider.dart';
import './providers/counter_provider.dart';
import './providers/bottomnav_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Counter()),
    ChangeNotifierProvider(create: (_) => BottomNavSelect()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const Auth(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
