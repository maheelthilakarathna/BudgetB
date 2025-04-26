import 'package:flutter/material.dart';
import 'home_screen.dart';  // Corrected import for home_screen.dart

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png', width: 200, height: 200),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Budget Bee',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Personal Finance Tracker')),
                );
              },
              child: const Text('Get Started'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
