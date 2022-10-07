import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workingauth/auth/auth_wrapper.dart';
import './config/firebase_options.dart';
import 'package:provider/provider.dart';
import './providers/counter_provider.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Counter()),
  ], child: MyApp(theme: theme)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.theme});

  final theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const Auth(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${context.watch<Counter>().counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<Counter>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
