import 'package:aplazo_app/data/local/purchase_database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplazo_app/domain/entities/purchase_entity.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> initInMemoryDatabase() async {
  return await openDatabase(
    inMemoryDatabasePath,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE purchases(id INTEGER PRIMARY KEY AUTOINCREMENT, customerId TEXT, amount REAL)',
      );
    },
  );
}

void main() {
  group('PurchaseDatabaseService Tests', () {
    late PurchaseDatabaseService purchaseDatabaseService;
    late Database db;

    setUp(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      db = await initInMemoryDatabase();

      purchaseDatabaseService = PurchaseDatabaseService();
      purchaseDatabaseService.testDatabase = db;
    });

    tearDown(() async {
      await db.close();
    });

    test('insertPurchase should insert a purchase into the database', () async {
      final purchase =
          PurchaseEntity(id: 1, customerId: 'customer123', amount: 100.0);

      await purchaseDatabaseService.insertPurchase(purchase);

      final List<Map<String, dynamic>> result = await db.query('purchases');
      expect(result.length, 1);
      expect(result[0]['customerId'], 'customer123');
      expect(result[0]['amount'], 100.0);
    });

    test('getPurchases should return a list of purchases', () async {
      await db
          .insert('purchases', {'customerId': 'customer123', 'amount': 100.0});
      await db
          .insert('purchases', {'customerId': 'customer456', 'amount': 200.0});

      final purchases = await purchaseDatabaseService.getPurchases();

      expect(purchases.length, 2);
      expect(purchases[0].customerId, 'customer123');
      expect(purchases[0].amount, 100.0);
      expect(purchases[1].customerId, 'customer456');
      expect(purchases[1].amount, 200.0);
    });
  });
}
