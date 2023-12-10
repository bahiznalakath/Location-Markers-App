import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/model_class.dart';

class DataBaseController {
  static final DataBaseController instance = DataBaseController._init();
  static Database? _database;
  static const String tableLocationModel = 'LocationModel';

  DataBaseController._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('location.db');
    return _database!;
  }

  Future<Database> _initDB(String fillPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fillPath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableLocationModel (
        id INTEGER PRIMARY KEY,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        postalCode TEXT NOT NULL,
        street TEXT NOT NULL,
        subLocality TEXT NOT NULL,
        country TEXT NOT NULL
      )
    ''');
  }

  Future<LocationModel> create(LocationModel locationModel) async {
    final db = await instance.database;
    final id = await db.insert(tableLocationModel, locationModel.toJson());
    final createdLocation = locationModel.copyWith(id: id);
    return createdLocation;
  }

  Future<int> update(LocationModel locationModel) async {
    final db = await instance.database;

    return db.update(
      tableLocationModel,
      locationModel.toJson(),
      where: 'id = ?',
      whereArgs: [locationModel.id],
    );
  }

  Future<LocationModel> readLocation(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLocationModel,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LocationModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<LocationModel>> readAllLocations() async {
    final db = await instance.database;

    final orderBy = 'id';
    final result = await db.query(tableLocationModel, orderBy: orderBy);

    return result.map((json) => LocationModel.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableLocationModel,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
