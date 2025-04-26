import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Budget')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Budget logic goes here
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Budget Set')));
          },
          child: const Text('Set Budget'),
        ),
      ),
    );
  }
}
