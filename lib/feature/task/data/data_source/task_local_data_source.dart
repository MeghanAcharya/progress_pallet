import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class TaskLocalDataSource {
  static TaskLocalDataSource?
      _localDatabaseHelper; //Singleton object of the class
  static Database? _database;

  TaskLocalDataSource._createInstance();

  final String taskTableName = "task";
  final String appDb = 'app_database.db';
  factory TaskLocalDataSource() {
    //initializing the object
    _localDatabaseHelper ??= TaskLocalDataSource._createInstance();
    return _localDatabaseHelper!;
  }
  // Getter for our database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  // Function to initialize the database
  Future<Database> initializeDatabase() async {
    // Getting directory path for both Android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + appDb;
    // Open or create database at a given path.
    var database =
        await openDatabase(path, version: 1, onCreate: _createTaskTable);
    printMessage("Database Created");
    return database;
  }

  Future<void> upsertTask(String? id, Map<String, dynamic>? task) async {
    if (task == null) return; // No action if the task is empty

    final db = await database;

    // Check if the record exists
    final existingRecord = await db.query(
      taskTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (existingRecord.isEmpty) {
      // Insert a new record if no existing record found
      await db.insert(
        taskTableName,
        task,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      // Update only non-null values in the existing record
      final filteredTask = task..removeWhere((key, value) => value == null);
      if (filteredTask.isNotEmpty) {
        await db.update(
          taskTableName,
          filteredTask,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }
  }

  void _createTaskTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $taskTableName (
      id TEXT PRIMARY KEY,

      content TEXT,
      description TEXT,
      priority INTEGER,
      status TEXT,
      start_time TEXT,
      end_time TEXT
    )
  ''');
  }

  //Fetch operation
  Future<List<TaskData>> getTasks() async {
    final db = await database;
    // Query all tasks from the tasks table
    final List<Map<String, dynamic>> maps = await db.query(taskTableName);

    // Convert the list of maps to a list of Task objects
    return List.generate(maps.length, (i) {
      return TaskData.fromJson(maps[i]);
    });
  }

  Future<TaskData?> getTaskDetail(String id) async {
    List<TaskData>? allTasks = await getTasks();
    return allTasks.firstWhere((element) => element.id == id);
  }
}
