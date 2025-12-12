import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('OrderScreen', () {
    testWidgets('displays the initial UI elements correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            routes: {
              '/order': (context) => const OrderScreen(),
              '/cart': (context) => Container(),
              '/profile': (context) => Container(),
              '/settings': (context) => Container(),
            },
            home: const OrderScreen(),
          ),
        ),
      );

      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsOneWidget);
    });

    testWidgets('shows sandwich controls',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            routes: {
              '/order': (context) => const OrderScreen(),
            },
            home: const OrderScreen(),
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget); // Size toggle
      expect(find.byType(DropdownMenu), findsAtLeastNWidgets(1)); // Sandwich type
      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('displays cart indicator in app bar',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            home: const OrderScreen(),
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.text('0'), findsOneWidget); // Empty cart count
    });

    testWidgets('can add items to cart',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            home: const OrderScreen(),
          ),
        ),
      );

      // Tap add to cart button
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Should show confirmation
      expect(find.textContaining('Added'), findsOneWidget);
    });
  });
}
