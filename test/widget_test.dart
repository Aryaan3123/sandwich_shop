import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Basic UI', () {
    testWidgets('shows initial UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(
          find.text('Veggie Delight'), findsOneWidget); // Default sandwich type
      expect(find.byType(Switch), findsOneWidget); // Size toggle
      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('shows quantity controls', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Quantity: '), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // Initial quantity
      expect(find.byIcon(Icons.add), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity Controls', () {
    testWidgets('increments quantity when + button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Find the + button in the quantity row (not the Add to Cart button)
      final addButtons = find.byIcon(Icons.add);
      expect(addButtons, findsAtLeastNWidgets(1));

      // Tap the quantity increment button
      await tester.tap(addButtons.first);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decrements quantity when - button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // First increment to 2
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Then decrement back to 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('does not decrement below 0', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);

      // Try to decrement below 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Should be 0 (minimum allowed)
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('toggles sandwich size with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Footlong'), findsOneWidget);
      expect(find.text('Six-inch'), findsOneWidget);

      // Toggle to six-inch
      await tester.tap(find.byType(Switch));
      await tester.pump();

      // Both labels should still be visible, just switch state changed
      expect(find.text('Footlong'), findsOneWidget);
      expect(find.text('Six-inch'), findsOneWidget);
    });

    testWidgets('changes sandwich type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Check initial sandwich type
      expect(find.text('Veggie Delight'), findsOneWidget);

      // Open dropdown and select different sandwich
      await tester.tap(find.byType(DropdownMenu<SandwichType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();

      expect(find.text('Chicken Teriyaki'), findsOneWidget);
    });

    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Open bread dropdown and select different bread
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();

      // Verify bread type changed (this may be visible in dropdown or other UI)
      expect(find.text('wheat'), findsAtLeastNWidgets(1));
    });
  });
  group('OrderScreen - Cart Functionality', () {
    testWidgets('cart summary is hidden when cart is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Initially cart should be empty and summary should not be visible
      expect(find.text('Cart Summary'), findsNothing);
      expect(find.text('Total Items: 0'), findsNothing);
      expect(find.textContaining('Total Price: £'), findsNothing);
    });
    testWidgets('adds item to cart and shows SnackBar confirmation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Tap Add to Cart button
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Should show snackbar confirmation
      expect(find.textContaining('Added'), findsOneWidget);
      expect(find.text('VIEW CART'), findsOneWidget);
    });

    testWidgets('cart summary appears after adding first item',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add item to cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Cart summary should appear immediately
      expect(find.text('Cart Summary'), findsOneWidget);
      expect(find.text('Total Items: 1'), findsOneWidget);
      expect(find.textContaining('Total Price: £'), findsOneWidget);
      expect(find.text('View Cart'), findsOneWidget);
    });
    testWidgets('cart summary updates correctly with multiple items',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Increase quantity to 3
      await tester.tap(find.byIcon(Icons.add)); // quantity becomes 2
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add)); // quantity becomes 3
      await tester.pump();

      // Add 3 items to cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Check cart summary shows correct totals
      expect(find.text('Cart Summary'), findsOneWidget);
      expect(find.text('Total Items: 3'), findsOneWidget);
      expect(find.text('Total Price: £33.00'),
          findsOneWidget); // 3 * £11 for footlong
    });
    testWidgets('cart summary updates when adding different sandwiches',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add first sandwich (default: Veggie Delight, footlong, quantity 1)
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      expect(find.text('Total Items: 1'), findsOneWidget);
      expect(find.text('Total Price: £11.00'), findsOneWidget);

      // Change to six-inch (quantity should reset to 1 after previous add)
      await tester.tap(find.byType(Switch));
      await tester.pump();

      // Add second sandwich (six-inch, quantity 1)
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Cart should now have 2 items with different prices
      expect(find.text('Total Items: 2'), findsOneWidget);
      expect(find.text('Total Price: £18.00'), findsOneWidget); // £11 + £7
    });
    testWidgets('View Cart button shows detailed cart dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add item to cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Tap View Cart button in cart summary
      await tester.tap(find.text('View Cart'));
      await tester.pumpAndSettle();

      // Check dialog appears with cart contents
      expect(find.text('Cart Contents'), findsOneWidget);
      expect(find.textContaining('Veggie Delight'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
      expect(find.text('Clear Cart'), findsOneWidget);
    });

    testWidgets('Clear Cart button empties cart and hides summary',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add item to cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      expect(find.text('Cart Summary'), findsOneWidget);

      // Open cart dialog and clear cart
      await tester.tap(find.text('View Cart'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clear Cart'));
      await tester.pumpAndSettle();

      // Cart summary should disappear
      expect(find.text('Cart Summary'), findsNothing);
      expect(find.text('Total Items: 0'), findsNothing);
    });

    testWidgets('SnackBar VIEW CART button opens cart dialog',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add item to cart to show SnackBar
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Tap VIEW CART in SnackBar
      await tester.tap(find.text('VIEW CART'));
      await tester.pumpAndSettle();

      // Check cart dialog opens
      expect(find.text('Cart Contents'), findsOneWidget);
      expect(find.textContaining('Cart Summary:'), findsOneWidget);
    });
  });
  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
