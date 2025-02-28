import 'package:flutter/material.dart';
import 'dart:async';
import 'auth_screen.dart';

class QuantumSplashScreen extends StatefulWidget {
  @override
  _QuantumSplashScreenState createState() => _QuantumSplashScreenState();
}

class _QuantumSplashScreenState extends State<QuantumSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Redirect to AuthScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(), // Redirects to Authentication
        ),
      );
    });

    // Quantum animation effect
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Quantum Glowing Circle
                Container(
                  width: 200 * _animation.value,
                  height: 200 * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.8),
                        blurRadius: 50,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
                // AutoForenX Logo
                Text(
                  "AutoForenX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    shadows: [Shadow(color: Colors.blueAccent, blurRadius: 20)],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
