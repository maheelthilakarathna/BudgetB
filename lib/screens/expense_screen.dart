import 'package:flutter/material.dart';
import '../database/db_helper.dart';  // Import DBHelper

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final DBHelper _dbHelper = DBHelper(); // Create an instance of DBHelper

  // Add an expense transaction
  void _addExpense() async {
    Map<String, dynamic> transaction = {
      'category': 'Groceries',
      'amount': 50.0,
      'type': 'Expense',
      'date': DateTime.now().toString(),
    };
    await _dbHelper.insertTransaction(transaction); // Insert the transaction into DB
    setState(() {}); // Refresh the UI
  }

  // Fetch all expenses from DB
  Future<List<Map<String, dynamic>>> _fetchExpenses() async {
    return await _dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Expenses')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No expenses added.'));
          }

          // Display all expenses
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var transaction = snapshot.data![index];
              return ListTile(
                title: Text(transaction['category']),
                subtitle: Text('Amount: \$${transaction['amount']}'),
                trailing: Text('Date: ${transaction['date']}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}
