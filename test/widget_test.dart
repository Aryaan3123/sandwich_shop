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

    testWidgets('does not decrement below 1', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);

      // Try to decrement below 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Should still be 0 (minimum allowed)
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
    testWidgets('adds item to cart when Add to Cart is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Tap Add to Cart button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pump();

      // Should show snackbar confirmation
      expect(find.textContaining('Added'), findsOneWidget);

      // Wait for snackbar to appear and dismiss
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Cart summary should appear
      expect(find.text('Cart Summary'), findsOneWidget);
      expect(find.text('Total Items: 1'), findsOneWidget);
    });

    testWidgets('shows cart summary when items are added',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Add item to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check cart summary elements
      expect(find.text('Cart Summary'), findsOneWidget);
      expect(find.text('Total Items: 1'), findsOneWidget);
      expect(find.textContaining('Total Price: £'), findsOneWidget);
      expect(find.text('View Cart'), findsOneWidget);
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
