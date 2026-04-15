import 'package:alabtechnology/alabtechnology.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: AppTextTheme.textTheme()),
      home: Scaffold(
        body: Center(child: SocialMediaView()),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: .center,
            children: [AppVersionInfo(version: "1.0.4+2", isProduction: true)],
          ),
        ),
      ),
    );
  }
}
