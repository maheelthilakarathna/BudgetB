import 'package:flutter/material.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Financial Goals')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic for adding financial goals
          },
          child: const Text('Add Goal'),
        ),
      ),
    );
  }
}
