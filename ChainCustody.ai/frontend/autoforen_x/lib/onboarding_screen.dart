import 'package:flutter/material.dart';
import 'dart:async';
import 'auth_screen.dart';

class QuantumSplashScreen extends StatefulWidget {
  @override
  _QuantumSplashScreenState createState() => _QuantumSplashScreenState();
}

class _QuantumSplashScreenState extends State<QuantumSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(), // Move to onboarding
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glowing Quantum Circle Effect
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.blueAccent, Colors.transparent],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.7),
                    blurRadius: 50,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
            Text(
              "AutoForenX",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
