
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {

  String dbName = "visitme.db";

  static final DBManager instance = DBManager._init();

  DBManager._init();

  Future<Database> get database async {
    // DB Path
    final dbPath = await getDatabasesPath();
    // Path
    final path = join(dbPath , dbName);
    // Open DB
    return openDatabase(path, version: 1, onCreate: _onCreateTable);
  }

  Future<void> _onCreateTable(Database db, int version) async{

    String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    String textType = "TEXT";
    String intType = "INTEGER";
    String doubleType = "REAL";

    String categoryTable = '''
        CREATE TABLE IF NOT EXISTS category(
          id $idType,
          name $textType
        )
        ''';
    await db.execute(categoryTable);

    String productTable = '''
        CREATE TABLE IF NOT EXISTS product(
          id $idType,
          name $textType,
          description $textType,
          price $doubleType,
          discount $intType
        )
        ''';
    await db.execute(productTable);

    String cartTable = '''
        CREATE TABLE IF NOT EXISTS cart(
          id $idType,
          product_id $textType,
          qty $textType,
          price $doubleType,
          discount $intType,
          total_amount $doubleType
        )
        ''';
    await db.execute(cartTable);
  }
}