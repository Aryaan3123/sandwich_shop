import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
// import 'package:sandwich_shop/models/bread_type.dart';

void main() {
  group('Sandwich Model', () {
    
    group('Constructor', () {
      test('creates sandwich with all required properties', () {
        // Arrange & Act
        final sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wheat,
        );

        // Assert
        expect(sandwich.type, SandwichType.veggieDelight);
        expect(sandwich.isFootlong, true);
        expect(sandwich.breadType, BreadType.wheat);
      });

      test('creates six-inch sandwich', () {
        // Arrange & Act
        final sandwich = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.white,
        );

        // Assert
        expect(sandwich.isFootlong, false);
        expect(sandwich.type, SandwichType.chickenTeriyaki);
      });

      test('creates sandwich with different bread types', () {
        // Test white bread
        final whiteSandwich = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.white,
        );

        // Test wheat bread
        final wheatSandwich = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        // Test wholemeal bread
        final wholemealSandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wholemeal,
        );

        // Assert
        expect(whiteSandwich.breadType, BreadType.white);
        expect(wheatSandwich.breadType, BreadType.wheat);
        expect(wholemealSandwich.breadType, BreadType.wholemeal);
      });
    });

    group('Name Getter', () {
      test('returns correct name for Veggie Delight', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white,
        );

        // Act & Assert
        expect(sandwich.name, 'Veggie Delight');
      });

      test('returns correct name for Chicken Teriyaki', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        // Act & Assert
        expect(sandwich.name, 'Chicken Teriyaki');
      });

      test('returns correct name for Tuna Melt', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.wholemeal,
        );

        // Act & Assert
        expect(sandwich.name, 'Tuna Melt');
      });

      test('returns correct name for Meatball Marinara', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: false,
          breadType: BreadType.white,
        );

        // Act & Assert
        expect(sandwich.name, 'Meatball Marinara');
      });
    });

    group('Image Getter', () {
      test('returns correct image path for footlong sandwich', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white,
        );

        // Act & Assert
        expect(sandwich.image, 'assets/images/veggieDelight_footlong.png');
      });

      test('returns correct image path for six-inch sandwich', () {
        // Arrange
        final sandwich = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        // Act & Assert
        expect(sandwich.image, 'assets/images/chickenTeriyaki_six_inch.png');
      });

      test('returns correct image paths for all sandwich types', () {
        // Test all sandwich types as footlong
        final veggie = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white,
        );
        
        final chicken = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: true,
          breadType: BreadType.wheat,
        );
        
        final tuna = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.wholemeal,
        );
        
        final meatball = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: true,
          breadType: BreadType.white,
        );

        // Assert
        expect(veggie.image, 'assets/images/veggieDelight_footlong.png');
        expect(chicken.image, 'assets/images/chickenTeriyaki_footlong.png');
        expect(tuna.image, 'assets/images/tunaMelt_footlong.png');
        expect(meatball.image, 'assets/images/meatballMarinara_footlong.png');
      });

      test('returns correct image paths for six-inch sizes', () {
        // Test all sandwich types as six-inch
        final veggie = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white,
        );
        
        final chicken = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        // Assert
        expect(veggie.image, 'assets/images/veggieDelight_six_inch.png');
        expect(chicken.image, 'assets/images/chickenTeriyaki_six_inch.png');
      });
    });

    group('Property Combinations', () {
      test('handles all combinations of properties correctly', () {
        // Test multiple property combinations
        final sandwiches = [
          Sandwich(
            type: SandwichType.veggieDelight,
            isFootlong: true,
            breadType: BreadType.white,
          ),
          Sandwich(
            type: SandwichType.chickenTeriyaki,
            isFootlong: false,
            breadType: BreadType.wheat,
          ),
          Sandwich(
            type: SandwichType.tunaMelt,
            isFootlong: true,
            breadType: BreadType.wholemeal,
          ),
        ];

        // Assert all properties are set correctly
        expect(sandwiches[0].type, SandwichType.veggieDelight);
        expect(sandwiches[0].isFootlong, true);
        expect(sandwiches[0].breadType, BreadType.white);

        expect(sandwiches[1].type, SandwichType.chickenTeriyaki);
        expect(sandwiches[1].isFootlong, false);
        expect(sandwiches[1].breadType, BreadType.wheat);

        expect(sandwiches[2].type, SandwichType.tunaMelt);
        expect(sandwiches[2].isFootlong, true);
        expect(sandwiches[2].breadType, BreadType.wholemeal);
      });

      test('creates multiple different sandwich instances', () {
        // Arrange & Act
        final sandwich1 = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white,
        );

        final sandwich2 = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        // Assert they are different objects with different properties
        expect(sandwich1.type != sandwich2.type, true);
        expect(sandwich1.isFootlong != sandwich2.isFootlong, true);
        expect(sandwich1.breadType != sandwich2.breadType, true);
        expect(sandwich1.name != sandwich2.name, true);
        expect(sandwich1.image != sandwich2.image, true);
      });
    });
  });
}