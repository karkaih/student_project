import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async'
import 'dart:io';
import 'package:intro_to_db/models/student.dart';

class SQL_Helper {
  //attributes
  static SQL_Helper dbHelper;
  static Database _database;

  //create instance
  SQL_Helper._createInstance();

// constuctor
  factory SQL_Helper() {
    if (dbHelper == null) {
      dbHelper = SQL_Helper._createInstance();
    }
    return dbHelper;
  }

  // get database
  Future <Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // name of table
  String tableName = "students_table";

  //  table colmun
  String _id = "id";
  String _name = "name";
  String _desc = "desc";
  String _pass = "pass";
  String _date = "date";

//initializeDatabase
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pat = directory.path + "students.db";

    var studentDB =
    await openDatabase(pat, version: 1, onCreate: createDatabase);

    return studentDB;
  }

  // create database
  void createDatabase(Database db, int version) async {
    await db.execute(
        "Create table $tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT , " +
            "$_name  TEXT , $_desc TEXT ,$_pass INTEGER ,$_date TEXT) ");
  }

  //get all data from table

  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database db = await this.database;
//var result1 = await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC ") ;
    var result = await db.query(tableName, orderBy: _id + "ASC");
    return result;
  }

  //INSERT

  Future<int> insertStudent(Student student) async {
    Database db = await this.database;
    var result = await db.insert(tableName, student.toMap());
    return result;
  }

// Update

  Future<int> updateStudent(Student student) async {
    Database db = await this.database;

    var result = await db.update(tableName, student.toMap(),
        where: "$_id = ? ", whereArgs: [student.id]);
    return result;
  }

// Delete

  Future<int> deleteStudent(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete("DELETE from  $tableName WHERE $_id = $id");

    return result;
  }

  // Count of all database

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all = await db.rawQuery(
        "SELECT COUNT (*) from $tableName ");
    int result = Sqflite.firstIntValue(all);
    return result;
  }

// get Students as a list of students
  Future <List<Student>> getStudentList() async {
    var studentMapList = await getStudentMapList();
    int count = studentMapList.length;
    List<Student> students = new List<Student> ();
    for (int i = 0; i <= count; i++) {
      students.add(Student.getMap(studentMapList[i]));
    }
    return students;
  }

}
