import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/bread_type.dart';
void main() {
  group('Sandwich Model', () {
    test('creates sandwich with all properties', () {
      // Arrange & Act
      final sandwich = Sandwich(
        breadType: BreadType.wheat,
        isFootlong: true,
        isToasted: false,
        notes: 'Extra cheese',
      );

      // Assert
      expect(sandwich.breadType, BreadType.wheat);
      expect(sandwich.isFootlong, true);
      expect(sandwich.isToasted, false);
      expect(sandwich.notes, 'Extra cheese');
    });

    test('creates sandwich with default values', () {
      // Arrange & Act
      final sandwich = Sandwich(
        breadType: BreadType.white,
        isFootlong: false,
        isToasted: true,
        notes: '',
      );

      // Assert
      expect(sandwich.breadType, BreadType.white);
      expect(sandwich.isFootlong, false);
      expect(sandwich.isToasted, true);
      expect(sandwich.notes, '');
    });
  });
}