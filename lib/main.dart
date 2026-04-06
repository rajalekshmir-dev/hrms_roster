import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      /// Apply your theme
      theme: AppTheme.lightTheme,

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HRMSAppBar(),
      body: const Center(child: Text("Background color applied from AppTheme")),
    );
  }
}
