import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Sandwich Shop', home: OrderScreen(maxQuantity: 5));
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

enum SandwichType { footlong, sixInch }

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  SandwichType _selectedSandwichType = SandwichType.footlong;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _increaseQuantity() {
    setState(() => _quantity++);
  }

  void _decreaseQuantity() {
    setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              _selectedSandwichType == SandwichType.footlong
                  ? 'Footlong'
                  : 'Six-inch',
            ),
            const SizedBox(height: 20),
            DropdownButton<SandwichType>(
              value: _selectedSandwichType,
              onChanged: (SandwichType? newValue) {
                setState(() {
                  _selectedSandwichType = newValue!;
                });
              },
              items: const [
                DropdownMenuItem<SandwichType>(
                  value: SandwichType.footlong,
                  child: Text('Footlong'),
                ),
                DropdownMenuItem<SandwichType>(
                  value: SandwichType.sixInch,
                  child: Text('Six-inch'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter Preferences...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // Set onPressed to null when max quantity is reached
                  onPressed:
                      _quantity < widget.maxQuantity ? _increaseQuantity : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shadowColor: Colors.greenAccent,
                    elevation: 5,
                  ),
                  child: const Text('Add'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  // Set onPressed to null when quantity is zero
                  onPressed: _quantity > 0 ? _decreaseQuantity : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shadowColor: Colors.greenAccent,
                    elevation: 5,
                  ),
                  child: const Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}
