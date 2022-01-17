import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/favorite_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /// Private Instance
  DatabaseHelper._();

  static DatabaseHelper db = DatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  static initDB() async {
    String path = join(await getDatabasesPath(), 'Products.db');

    return await openDatabase(path,
        version: 1,
        onCreate: (Database db, int version) async {
          debugPrint('Database Created!');
          await db
              .execute('''CREATE TABLE $tableCartProduct (
        $cartColumnName TEXT NOT NULL, 
        $cartColumnImage TEXT NOT NULL, 
        $cartColumnPrice REAL NOT NULL, 
        $cartColumnQuantity INTEGER NOT NULL )
        ''')
              .then((value) => debugPrint('Cart Table Created!'))
              .catchError((e) => debugPrint('Error when Creating Cart Table!'));

          await db
              .execute('''CREATE TABLE $tableFavoriteProduct (
        $favoriteColumnName TEXT NOT NULL, 
        $favoriteColumnImage TEXT NOT NULL, 
        $favoriteColumnRate REAL NOT NULL,
        $favoriteColumnPriceAfterDiscount REAL NOT NULL,       
        $favoriteColumnPrice REAL NOT NULL, 
        $favoriteColumnDiscount INTEGER NOT NULL)
        ''')
              .then((value) => debugPrint('Favorite Table Created!'))
              .catchError((e) => debugPrint(
                  'Error when Creating Favorite Table! ${e.toString()}'));
        },
        onOpen: (db) => debugPrint('Database Opened!'));
  }

  // static void createDatabase() {
  //   openDatabase('TODO.db', version: 1, onCreate: (db, version) {
  //     debugPrint('Database Created!');
  //     db
  //         .execute('''CREATE TABLE $tableCartProduct (
  //       $cartColumnName TEXT NOT NULL,
  //       $cartColumnImage TEXT NOT NULL,
  //       $cartColumnPrice TEXT NOT NULL,
  //       $cartColumnQuantity INTEGER NOT NULL )
  //       ''')
  //         .then((value) => debugPrint('Cart Table Created!'))
  //         .catchError((e) =>
  //             debugPrint('Error when Creating Cart Table! ${e.toString()}'));
  //
  //     db
  //         .execute('''CREATE TABLE $tableFavoriteProduct (
  //       $favoriteColumnName TEXT NOT NULL,
  //       $favoriteColumnImage TEXT NOT NULL,
  //       $favoriteColumnRate REAL NOT NULL,
  //       $favoriteColumnPriceAfterDiscount REAL NOT NULL,
  //       $favoriteColumnPrice REAL NOT NULL,
  //       $favoriteColumnDiscount INTEGER NOT NULL)
  //       ''')
  //         .then((value) => debugPrint('Favorite Table Created!'))
  //         .catchError((e) => debugPrint(
  //             'Error when Creating Favorite Table! ${e.toString()}'));
  //   }, onOpen: (db) {
  //     debugPrint('Database Opened! ${db.path}');
  //   }).then((value) {
  //     _database = value;
  //   });
  // }

  insertIntoCart(CartProductModel model) async {
    var dbClient = await database;
    await dbClient?.insert(tableCartProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  insertIntoFavorite(FavoriteProductModel model) async {
    var dbClient = await database;
    await dbClient?.insert(tableFavoriteProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartProductModel>> getAllCartProduct() async {
    var dbClient = await database;
    List<Map<String, Object?>>? maps = await dbClient?.query(tableCartProduct);

    List<CartProductModel> list = maps!.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];

    return list;
  }
}
