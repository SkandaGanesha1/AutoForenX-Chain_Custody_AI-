import 'package:flutter/material.dart';
import 'screens/BiometricAuthScreen.dart';

void main() {
  runApp(const ChainCustodyApp());
}

class ChainCustodyApp extends StatelessWidget {
  const ChainCustodyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChainCustody.ai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BiometricAuthScreen(),
    );
  }
}