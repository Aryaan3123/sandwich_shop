import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sandwich_shop/models/saved_order.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'orders.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId TEXT NOT NULL,
        totalAmount REAL NOT NULL,
        itemCount INTEGER NOT NULL,
        orderDate INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertOrder(SavedOrder order) async {
    final db = await database;

    // Convert to JSON, then create a map for SQLite
    final jsonData = order.toJson();

    // Remove id for insertion (SQLite auto-generates it)
    final Map<String, dynamic> insertData = Map.from(jsonData);
    insertData.remove('id');

    // Convert DateTime to milliseconds for SQLite storage
    if (insertData['orderDate'] is String) {
      insertData['orderDate'] =
          DateTime.parse(insertData['orderDate']).millisecondsSinceEpoch;
    } else if (insertData['orderDate'] is DateTime) {
      insertData['orderDate'] =
          (insertData['orderDate'] as DateTime).millisecondsSinceEpoch;
    }

    return await db.insert('orders', insertData);
  }

  Future<List<SavedOrder>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');

    return List.generate(maps.length, (i) {
      // Convert SQLite data back to JSON format
      final map = Map<String, dynamic>.from(maps[i]);

      // Convert milliseconds back to DateTime string for JSON parsing
      if (map['orderDate'] is int) {
        map['orderDate'] = DateTime.fromMillisecondsSinceEpoch(map['orderDate'])
            .toIso8601String();
      }

      return SavedOrder.fromJson(map);
    });
  }

  Future<void> deleteOrder(int id) async {
    final db = await database;
    await db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
