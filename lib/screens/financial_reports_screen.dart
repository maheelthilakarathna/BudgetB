import 'package:flutter/material.dart';

class FinancialReportsScreen extends StatelessWidget {
  const FinancialReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Reports')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Logic to display income vs expense chart/graph
              },
              child: const Text('View Income vs Expense Report'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logic to display goal progress chart/graph
              },
              child: const Text('View Goal Progress Report'),
            ),
          ],
        ),
      ),
    );
  }
}
