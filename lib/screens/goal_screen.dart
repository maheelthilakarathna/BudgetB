import 'package:flutter/material.dart';
import '../database/db_helper.dart'; // DBHelper for handling database

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final DBHelper _dbHelper = DBHelper();

  TextEditingController _goalNameController = TextEditingController();
  TextEditingController _targetAmountController = TextEditingController();

  // Add a goal
  void _addGoal() async {
    if (_goalNameController.text.isEmpty || _targetAmountController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> goal = {
      'name': _goalNameController.text,
      'targetAmount': double.parse(_targetAmountController.text),
      'date': DateTime.now().toString(),
    };

    await _dbHelper.insertGoal(goal); // Insert into DB
    setState(() {});  // Refresh the screen after insertion
  }

  // Fetch all goals from DB
  Future<List<Map<String, dynamic>>> _fetchGoals() async {
    return await _dbHelper.getGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Financial Goals'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _goalNameController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                labelStyle: TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _targetAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Amount',
                labelStyle: TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.black12,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addGoal,
            child: const Text('Save Goal'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchGoals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No goals available.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var goal = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.black,
                      child: ListTile(
                        title: Text(goal['name'],
                            style: TextStyle(color: Colors.yellow)),
                        subtitle: Text('Target: \$${goal['targetAmount']}',
                            style: TextStyle(color: Colors.yellow)),
                        trailing: Text('Date: ${goal['date']}',
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
