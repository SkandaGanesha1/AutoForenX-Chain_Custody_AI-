import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'EvidenceUploadScreen.dart';

class BiometricAuthScreen extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateUser() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access evidence',
        options: const AuthenticationOptions(stickyAuth: true),
      );
    } catch (e) {
      print("Error during authentication: $e");
    }
    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Biometric Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool isAuthenticated = await authenticateUser();
            if (isAuthenticated) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EvidenceUploadScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Authentication failed!")),
              );
            }
          },
          child: Text("Login with Biometrics"),
        ),
      ),
    );
  }
}