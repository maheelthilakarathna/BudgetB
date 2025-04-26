import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'finance_tracker.db'),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            amount REAL,
            type TEXT,
            date TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE budgets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            date TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE goals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            targetAmount REAL,
            date TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Insert transaction (Expense or Income)
  Future<void> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    await db.insert(
      'transactions',
      transaction,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get transactions (Expense or Income)
  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.query('transactions');
  }

  // Insert a budget
  Future<void> insertBudget(Map<String, dynamic> budget) async {
    final db = await database;
    await db.insert(
      'budgets',
      budget,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all budgets
  Future<List<Map<String, dynamic>>> getBudgets() async {
    final db = await database;
    return await db.query('budgets');
  }

  // Insert a goal
  Future<void> insertGoal(Map<String, dynamic> goal) async {
    final db = await database;
    await db.insert(
      'goals',
      goal,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all goals
  Future<List<Map<String, dynamic>>> getGoals() async {
    final db = await database;
    return await db.query('goals');
  }

  // Update a transaction
  Future<void> updateTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    await db.update(
      'transactions',
      transaction,
      where: 'id = ?',
      whereArgs: [transaction['id']],
    );
  }

  // Update a budget
  Future<void> updateBudget(Map<String, dynamic> budget) async {
    final db = await database;
    await db.update(
      'budgets',
      budget,
      where: 'id = ?',
      whereArgs: [budget['id']],
    );
  }

  // Update a goal
  Future<void> updateGoal(Map<String, dynamic> goal) async {
    final db = await database;
    await db.update(
      'goals',
      goal,
      where: 'id = ?',
      whereArgs: [goal['id']],
    );
  }

  // Delete a transaction
  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a budget
  Future<void> deleteBudget(int id) async {
    final db = await database;
    await db.delete(
      'budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a goal
  Future<void> deleteGoal(int id) async {
    final db = await database;
    await db.delete(
      'goals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
