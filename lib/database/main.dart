import 'package:sqflite/sqflite.dart';

late Database _database;

Future<Database> get database async {
  _database = await _initDb();
  return _database;
}

Future<Database> _initDb() async {
  var path = await getDatabasesPath();
  var db = openDatabase(
    '$path/restaurant.db',
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE favorite (
            id TEXT PRIMARY KEY
          )''');
    },
    version: 1,
  );
  return db;
}
