import 'package:flutter/material.dart';
import 'screens/expense_screen.dart';
import 'screens/income_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/goal_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/financial_reports_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Finance Tracker Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Navigate to the Expense Screen
  void _goToExpenseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseScreen()), // Removed `const`
    );
  }

  // Navigate to the Income Screen
  void _goToIncomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IncomeScreen()), // Removed `const`
    );
  }

  // Navigate to the Budget Screen
  void _goToBudgetScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BudgetScreen()), // Removed `const`
    );
  }

  // Navigate to the Goal Screen
  void _goToGoalScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoalScreen()), // Removed `const`
    );
  }

  // Navigate to the Transaction History Screen
  void _goToTransactionHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransactionHistoryScreen()), // Removed `const`
    );
  }

  // Navigate to the Financial Reports Screen
  void _goToReportsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinancialReportsScreen()), // Removed `const`
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Personal Finance Tracker'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToExpenseScreen,
              child: const Text('Track Expenses'),
            ),
            ElevatedButton(
              onPressed: _goToIncomeScreen,
              child: const Text('Track Income'),
            ),
            ElevatedButton(
              onPressed: _goToBudgetScreen,
              child: const Text('Manage Budget'),
            ),
            ElevatedButton(
              onPressed: _goToGoalScreen,
              child: const Text('Set Financial Goals'),
            ),
            ElevatedButton(
              onPressed: _goToTransactionHistoryScreen,
              child: const Text('Transaction History'),
            ),
            ElevatedButton(
              onPressed: _goToReportsScreen,
              child: const Text('View Reports'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
