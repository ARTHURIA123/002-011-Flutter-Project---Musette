import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DatabaseConnection{
  Future<Database>setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'MusicLibrary');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }
  Future<void>_createDatabase(Database database, int version) async {
    String sql=
        "CREATE TABLE musics (id INTEGER PRIMARY KEY,songName TEXT,artist Text,lyricist TEXT,composer TEXT,producer TEXT, label TEXT, isMonetize TEXT);";
    await database.execute(sql);
  }
}