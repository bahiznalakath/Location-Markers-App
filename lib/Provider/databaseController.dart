import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/model_class.dart';

ValueNotifier<List<LocationModel>> locationListNotifier = ValueNotifier([]);
late Database _db;

Future<void> initDataBase() async {
  _db = await openDatabase('location.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE Location (id INTEGER PRIMARY KEY, latitude TEXT, longitude TEXT, postalCode TEXT, street TEXT, subLocality TEXT, country TEXT)');
  });
}

Future<void> addLocation(LocationModel value) async {
  await _db.rawInsert(
      'INSERT INTO Location(latitude, longitude, postalCode, street, subLocality, country) VALUES(?,?,?,?,?,?)',
      [
        value.latitude,
        value.longitude,
        value.postalCode,
        value.street,
        value.subLocality,
        value.country,
      ]);
  getAllLocation();
  locationListNotifier
      .notifyListeners(); // Notify listeners that the list has changed
}

Future<void> getAllLocation() async {
  final _values = await _db.rawQuery("SELECT * FROM Location");
  print(_values);
  locationListNotifier.value.clear();
  _values.forEach((map) {
    final student = LocationModel.fromMap(map);
    locationListNotifier.value.add(student); // Add the student to the list
    locationListNotifier.notifyListeners();
  });
}

Future<void> deleteLocation(int id) async {
  await _db.delete('Location', where: 'id = ?', whereArgs: [
    id
  ]); // Delete the student with the specified ID from the database
  getAllLocation();
  // Refresh the student list
}
