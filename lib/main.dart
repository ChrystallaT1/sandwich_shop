import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
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

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  final TextEditingController _noteController = TextEditingController();

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandwich Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(_quantity, 'Footlong'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add a note to your order',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyledButton(
                  text: 'Add',
                  onPressed: _quantity < widget.maxQuantity
                      ? _increaseQuantity
                      : null,
                  backgroundColor: _quantity < widget.maxQuantity
                      ? Colors.green
                      : Colors.grey,
                ),
                StyledButton(
                  text: 'Remove',
                  onPressed: _quantity > 0 ? _decreaseQuantity : null,
                  backgroundColor: _quantity > 0 ? Colors.red : Colors.grey,
                ),
              ],
            ),
            if (_noteController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Note: ${_noteController.text}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$quantity $itemType sandwich(es): ${'🥪' * quantity}',
      style: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
