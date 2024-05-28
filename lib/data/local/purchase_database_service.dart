import 'package:aplazo_app/domain/entities/purchase_entity.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PurchaseDatabaseService {
  static final PurchaseDatabaseService _instance =
      PurchaseDatabaseService._internal();
  factory PurchaseDatabaseService() => _instance;
  static Database? _database;

  PurchaseDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  @visibleForTesting
  set testDatabase(Database database) {
    _database = database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'purchases.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE purchases(id INTEGER PRIMARY KEY AUTOINCREMENT, customerId TEXT, amount REAL)',
        );
      },
    );
  }

  Future<void> insertPurchase(PurchaseEntity purchase) async {
    final db = await database;
    await db.insert('purchases', purchase.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PurchaseEntity>> getPurchases() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('purchases');

    return List.generate(maps.length, (i) {
      return PurchaseEntity.fromMap(maps[i]);
    });
  }
}
