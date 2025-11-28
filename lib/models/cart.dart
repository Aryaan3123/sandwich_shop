import 'sandwich.dart';
import '../repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({
    required this.sandwich,
    this.quantity = 1,
  });
}

class Cart {
  final List<CartItem> _items = [];
  final PricingRepository _pricingRepository = PricingRepository();

  // Get all items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  // Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  // Get total number of items in cart
  int get totalItems {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  // Add a sandwich to the cart
  void addItem(Sandwich sandwich, {int quantity = 1}) {
    // Check if sandwich already exists in cart
    final existingIndex = _items.indexWhere((item) => 
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);

    if (existingIndex >= 0) {
      // Update existing item quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item to cart
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  // Remove a sandwich from the cart
  void removeItem(Sandwich sandwich) {
    _items.removeWhere((item) => 
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);
  }

  // Update quantity of a specific item
  void updateQuantity(Sandwich sandwich, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(sandwich);
      return;
    }

    final index = _items.indexWhere((item) => 
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);

    if (index >= 0) {
      _items[index].quantity = newQuantity;
    }
  }

  // Decrease quantity by 1
  void decrementItem(Sandwich sandwich) {
    final index = _items.indexWhere((item) => 
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    }
  }

  // Calculate total price using PricingRepository
  double get totalPrice {
    double total = 0.0;
    for (final item in _items) {
      double itemPrice = _pricingRepository.calculatePrice(
        quantity: item.quantity,
        isFootlong: item.sandwich.isFootlong,
      );
      total += itemPrice;
    }
    return total;
  }

  // Get price for a specific item
  double getItemPrice(CartItem item) {
    return _pricingRepository.calculatePrice(
      quantity: item.quantity,
      isFootlong: item.sandwich.isFootlong,
    );
  }

  // Clear all items from cart
  void clear() {
    _items.clear();
  }

  // Get quantity of a specific sandwich
  int getQuantity(Sandwich sandwich) {
    final item = _items.firstWhere(
      (item) => 
          item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType,
      orElse: () => CartItem(sandwich: sandwich, quantity: 0),
    );
    return item.quantity;
  }

  // Check if cart contains a specific sandwich
  bool contains(Sandwich sandwich) {
    return _items.any((item) => 
        item.sandwich.type == sandwich.type &&
        item.sandwich.isFootlong == sandwich.isFootlong &&
        item.sandwich.breadType == sandwich.breadType);
  }

  // Get cart summary as a formatted string
  String getSummary() {
    if (isEmpty) {
      return 'Your cart is empty';
    }

    StringBuffer summary = StringBuffer();
    summary.writeln('Cart Summary:');
    summary.writeln('─' * 30);
    
    for (final item in _items) {
      final price = getItemPrice(item);
      final sizeText = item.sandwich.isFootlong ? 'Footlong' : '6-inch';
      summary.writeln(
        '${item.quantity}x ${item.sandwich.name} ($sizeText) - £${price.toStringAsFixed(2)}'
      );
    }
    
    summary.writeln('─' * 30);
    summary.writeln('Total Items: $totalItems');
    summary.writeln('Total Price: £${totalPrice.toStringAsFixed(2)}');
    
    return summary.toString();
  }
}