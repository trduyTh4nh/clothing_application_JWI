import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tuan08/app/model/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'db_product_clothing.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(path, onCreate: _onCreate, version: 1
        // ,
        // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
        );
  }

  Future<void> _onCreate(Database db, int version) async {
    // await db.execute(
    //   'CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, desc TEXT); '
    // );
    await db.execute(
      'CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,price INTEGER,imageURL TEXT, description TEXT, categoryID INTEGER, categoryName TEXT,  idProductAPI INTEGER)',
    );
  }

  // insert product favorite
  Future<void> insertProduct(ProductModel product) async {
    final db = await _databaseService.database;
    await db.insert('product', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("Success");
  }

  // delete product
  Future<void> deleteProductFavorite(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // getALL
    Future<List<ProductModel>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('product');
    return List.generate(
        maps.length, (index) => ProductModel.fromMap(maps[index]));
  }
}
