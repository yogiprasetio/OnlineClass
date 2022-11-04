import 'package:sqflite/sqflite.dart';
import 'package:todoapps/data/model/to_do.dart';

class HelperDatabases {
  static late Database _database;

  static HelperDatabases? _databaseHelper;
  HelperDatabases._internal() {
    _databaseHelper = this;
  }

  factory HelperDatabases() => _databaseHelper ?? HelperDatabases._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'todos';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/todo_db.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT, detail TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertTodo(Todo todo) async {
    final Database db = await database;
    await db.insert(_tableName, todo.toMap());
    print('databases inserted');
  }

  Future<List<Todo>> getTodos() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    print('Get Todos');
    return results.map((res) => Todo.fromMap(res)).toList();
  }

  Future<Todo> getTodoBy(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: "id=?", whereArgs: [id]);
    return results.map((e) => Todo.fromMap(e)).first;
  }

  Future<Todo> getOldestTodo() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((e) => Todo.fromMap(e)).first;
  }

  Future<void> updateTodoBy(Todo todo) async {
    final Database db = await database;
    await db
        .update(_tableName, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodoBy(int id) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id=?', whereArgs: [id]);
  }
}
