import 'package:flutter/material.dart';
import '../database/db_helper.dart'; // DBHelper for handling database

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final DBHelper _dbHelper = DBHelper();
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  // Add income
  void _addIncome() async {
    if (_sourceController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> transaction = {
      'category': _sourceController.text,
      'amount': double.parse(_amountController.text),
      'type': 'Income',
      'date': DateTime.now().toString(),
    };

    await _dbHelper.insertTransaction(transaction); // Insert into DB
    setState(() {});  // Refresh the screen after insertion
  }

  // Fetch all income from DB
  Future<List<Map<String, dynamic>>> _fetchIncome() async {
    return await _dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Income'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: 'Income Source',
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
            onPressed: _addIncome,
            child: const Text('Add Income'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchIncome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No income available.'));
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
