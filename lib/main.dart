import 'package:flutter/material.dart';

import 'features/clean/presentation/pages/character_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeDI;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.blueGrey,
      ),
      home: CharacterPage(),
    );
  }
}
