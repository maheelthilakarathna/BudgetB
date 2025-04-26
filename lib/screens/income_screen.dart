import 'package:flutter/material.dart';
import '../database/db_helper.dart';  // Import DBHelper

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final DBHelper _dbHelper = DBHelper(); // Create an instance of DBHelper

  // Add an income transaction
  void _addIncome() async {
    Map<String, dynamic> transaction = {
      'category': 'Salary',
      'amount': 2000.0,
      'type': 'Income',
      'date': DateTime.now().toString(),
    };
    await _dbHelper.insertTransaction(transaction); // Insert the income transaction into DB
    setState(() {}); // Refresh the UI
  }

  // Fetch all income transactions from DB
  Future<List<Map<String, dynamic>>> _fetchIncome() async {
    return await _dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Income')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchIncome(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No income added.'));
          }

          // Display all income
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
        onPressed: _addIncome,
        tooltip: 'Add Income',
        child: const Icon(Icons.add),
      ),
    );
  }
}
