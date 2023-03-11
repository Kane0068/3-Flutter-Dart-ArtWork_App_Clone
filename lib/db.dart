import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db{
  Database? db;
  Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,"artwork.db");
    print(path);

    db = await openDatabase(path,version: 1,
    onCreate: (Database db ,int version) async {
      await db.execute('''
          CREATE TABLE artworks(
          id integer primary key autoIncrement,
          username varchar(255) not null,
          email varchar(255) not null,
          password varchar(255) not null);
      ''');
    });
  }
}
