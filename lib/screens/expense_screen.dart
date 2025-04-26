import 'package:flutter/material.dart';
import '../database/db_helper.dart'; // DBHelper for handling database

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final DBHelper _dbHelper = DBHelper();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  // Add an expense
  void _addExpense() async {
    if (_categoryController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> transaction = {
      'category': _categoryController.text,
      'amount': double.parse(_amountController.text),
      'type': 'Expense',
      'date': DateTime.now().toString(),
    };

    await _dbHelper.insertTransaction(transaction); // Insert into DB
    setState(() {});  // Refresh the screen after insertion
  }

  // Fetch all expenses from DB
  Future<List<Map<String, dynamic>>> _fetchExpenses() async {
    return await _dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Expenses'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addExpense,
            child: const Text('Add Expense'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchExpenses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No expenses available.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var transaction = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.black,
                      child: ListTile(
                        title: Text(transaction['category'],
                            style: TextStyle(color: Colors.yellow)),
                        subtitle: Text('Amount: \$${transaction['amount']}',
                            style: TextStyle(color: Colors.yellow)),
                        trailing: Text('Date: ${transaction['date']}',
                            style: TextStyle(color: Colors.yellow)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
