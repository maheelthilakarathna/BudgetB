import 'package:flutter/material.dart';
import '../database/db_helper.dart';  // Import DBHelper

class TransactionHistoryScreen extends StatelessWidget {
  // Remove const constructor as '_dbHelper' is initialized with a non-constant value.
  TransactionHistoryScreen({super.key});

  final DBHelper _dbHelper = DBHelper(); // Create an instance of DBHelper

  // Fetch all transactions and display them
  Future<List<Map<String, dynamic>>> _fetchTransactions() async {
    return await _dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No transactions available.'));
          }

          // Display all transactions
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var transaction = snapshot.data![index];
              return ListTile(
                title: Text(transaction['category'], style: TextStyle(color: Colors.yellow)),
                subtitle: Text('Amount: \$${transaction['amount']}', style: TextStyle(color: Colors.yellow)),
                trailing: Text('Date: ${transaction['date']}', style: TextStyle(color: Colors.yellow)),
              );
            },
          );
        },
      ),
    );
  }
}
