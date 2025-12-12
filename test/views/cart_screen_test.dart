import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CartScreen', () {
    testWidgets('displays empty cart message when cart is empty',
        (WidgetTester tester) async {
      final Cart emptyCart = Cart();
      
      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: emptyCart,
          child: MaterialApp(
            routes: {
              '/cart': (context) => const CartScreen(),
              '/order': (context) => Container(), // Mock route
            },
            home: const CartScreen(),
          ),
        ),
      );

      expect(find.text('Cart View'), findsOneWidget);
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays cart items when cart has items',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            routes: {
              '/cart': (context) => const CartScreen(),
              '/order': (context) => Container(),
            },
            home: const CartScreen(),
          ),
        ),
      );

      expect(find.text('Cart View'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsOneWidget);
    });

    testWidgets('shows cart summary correctly',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>.value(
          value: cart,
          child: MaterialApp(
            routes: {
              '/cart': (context) => const CartScreen(),
              '/checkout': (context) => Container(),
            },
            home: const CartScreen(),
          ),
        ),
      );

      expect(find.text('Cart View'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsAtLeastNWidgets(1));
    });
  });
}
