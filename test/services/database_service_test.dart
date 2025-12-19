import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/services/database_service.dart';
import 'package:sandwich_shop/models/saved_order.dart';

void main() {
  group('DatabaseService', () {
    late DatabaseService databaseService;

    setUp(() {
      databaseService = DatabaseService();
    });

    testWidgets('creates database service instance', (tester) async {
      expect(databaseService, isNotNull);
      expect(databaseService, isA<DatabaseService>());
    });

    testWidgets('database service has required methods', (tester) async {
      expect(databaseService.insertOrder, isA<Function>());
      expect(databaseService.getOrders, isA<Function>());
      expect(databaseService.deleteOrder, isA<Function>());
    });

    testWidgets('can create SavedOrder for database operations',
        (tester) async {
      final DateTime testDate = DateTime(2023, 12, 25, 14, 30);
      final SavedOrder order = SavedOrder(
        id: 0,
        orderId: 'ORD123456',
        totalAmount: 25.50,
        itemCount: 3,
        orderDate: testDate,
      );

      expect(order.orderId, equals('ORD123456'));
      expect(order.totalAmount, equals(25.50));
      expect(order.itemCount, equals(3));
      expect(order.orderDate, equals(testDate));
    });

    testWidgets('SavedOrder toJson excludes id field', (tester) async {
      final DateTime testDate = DateTime(2023, 12, 25, 14, 30);
      final SavedOrder order = SavedOrder(
        id: 1,
        orderId: 'ORD123456',
        totalAmount: 25.50,
        itemCount: 3,
        orderDate: testDate,
      );

      final Map<String, Object?> map = order.toJson();
      expect(map.containsKey('id'), isFalse);
      expect(map['orderId'], equals('ORD123456'));
      expect(map['totalAmount'], equals(25.50));
      expect(map['itemCount'], equals(3));
      expect(map['orderDate'], equals(testDate.millisecondsSinceEpoch));
    });
  });

  testWidgets('SavedOrder toJson includes all fields', (tester) async {
  final DateTime testDate = DateTime(2023, 12, 25, 14, 30);
  final SavedOrder order = SavedOrder(
    id: 1,
    orderId: 'ORD123456',
    totalAmount: 25.50,
    itemCount: 3,
    orderDate: testDate,
  );

  final Map<String, dynamic> json = order.toJson();
  
  // json_serializable includes ALL fields, including id
  expect(json.containsKey('id'), isTrue);
  expect(json['id'], equals(1));
  expect(json['orderId'], equals('ORD123456'));
  expect(json['totalAmount'], equals(25.50));
  expect(json['itemCount'], equals(3));
  
  // DateTime is serialized as ISO string by default
  expect(json['orderDate'], isA<String>());
});
}
