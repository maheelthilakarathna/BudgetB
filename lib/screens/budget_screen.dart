import 'package:flutter/material.dart';
import '../database/db_helper.dart';  // Import DBHelper

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final DBHelper _dbHelper = DBHelper(); // Create an instance of DBHelper

  final TextEditingController _budgetNameController = TextEditingController();
  final TextEditingController _budgetAmountController = TextEditingController();

  // Add a budget
  void _addBudget() async {
    if (_budgetNameController.text.isEmpty || _budgetAmountController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> budget = {
      'name': _budgetNameController.text,
      'amount': double.parse(_budgetAmountController.text),
      'date': DateTime.now().toString(),
    };
    await _dbHelper.insertBudget(budget); // Insert the budget into DB
    setState(() {}); // Refresh the UI
  }

  // Fetch all budgets from DB
  Future<List<Map<String, dynamic>>> _fetchBudgets() async {
    return await _dbHelper.getBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Budget')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _budgetNameController,
              decoration: const InputDecoration(labelText: 'Budget Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _budgetAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Budget Amount'),
            ),
          ),
          ElevatedButton(
            onPressed: _addBudget,
            child: const Text('Add Budget'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Yellow button
              foregroundColor: Colors.black, // Black text
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchBudgets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No budgets available.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var budget = snapshot.data![index];
                    return ListTile(
                      title: Text(budget['name'], style: TextStyle(color: Colors.yellow)),
                      subtitle: Text('Amount: \$${budget['amount']}', style: TextStyle(color: Colors.yellow)),
                      trailing: Text('Date: ${budget['date']}', style: TextStyle(color: Colors.yellow)),
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
