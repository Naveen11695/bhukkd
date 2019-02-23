import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/GeoCodeInfo/GeoCode.dart';

class GeoCodeProvider{
  Database db;

  // initial setup for the database
  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "GeoCode.db");
    // openDatabse will get the database if it exists or it will create it if no database
    db= await openDatabase(
     path,
     version:1, // it will give us a better idea of what state our database is in, if we want to change the schema then just increment the version
     onCreate: (Database newDb, int version){ // this fuction will be called when the database is created (only called once)

     } 
    ); 
  }
}