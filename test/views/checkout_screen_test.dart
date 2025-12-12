import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CheckoutScreen', () {
    testWidgets('displays checkout screen correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: const MaterialApp(
            home: CheckoutScreen(),
          ),
        ),
      );

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsAtLeastNWidgets(1));
    });

    testWidgets('shows cart items in checkout',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      cart.add(sandwich, quantity: 2);

      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: const MaterialApp(
            home: CheckoutScreen(),
          ),
        ),
      );

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
    });

    testWidgets('payment processing button exists',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: const MaterialApp(
            home: CheckoutScreen(),
          ),
        ),
      );

      expect(find.text('Checkout'), findsOneWidget);
      // Look for any payment-related button
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });
  });
}
