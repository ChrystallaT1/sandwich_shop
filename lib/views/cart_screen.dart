import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  Future<void> _navigateToCheckout() async {
    if (widget.cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cart: widget.cart),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        widget.cart.clearCart();
      });

      final String orderId = result['orderId'] as String;
      final String estimatedTime = result['estimatedTime'] as String;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order $orderId confirmed! Estimated time: $estimatedTime',
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  int _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculateTotalPrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  void _increaseQuantity(Sandwich sandwich, int currentQuantity) {
    setState(() {
      widget.cart.updateQuantity(sandwich, currentQuantity + 1);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${sandwich.name} quantity increased to ${currentQuantity + 1}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _decreaseQuantity(Sandwich sandwich, int currentQuantity) {
    final newQuantity = currentQuantity - 1;

    setState(() {
      widget.cart.updateQuantity(sandwich, newQuantity);
    });

    if (newQuantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${sandwich.name} removed from cart'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${sandwich.name} quantity decreased to $newQuantity'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _removeItem(Sandwich sandwich) {
    setState(() {
      widget.cart.removeSandwich(sandwich);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${sandwich.name} removed from cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text('Cart View', style: heading1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: widget.cart.items.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your cart is empty',
                      style: heading2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Add some delicious sandwiches to get started!',
                      style: normalText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    StyledButton(
                      onPressed: _goBack,
                      icon: Icons.arrow_back,
                      label: 'Back to Order',
                      backgroundColor: Colors.blue,
                    ),
                    const SizedBox(height: 40),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    for (MapEntry<Sandwich, int> entry
                        in widget.cart.items.entries)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(entry.key.name, style: heading2),
                                    Text(
                                      '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                                      style: normalText,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => _removeItem(entry.key),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                tooltip: 'Remove item',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    _decreaseQuantity(entry.key, entry.value),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('Qty: ${entry.value}', style: normalText),
                              IconButton(
                                onPressed: () =>
                                    _increaseQuantity(entry.key, entry.value),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          Text(
                            '£${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                            style: normalText,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Text(
                      'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                      style: heading2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    StyledButton(
                      onPressed: _navigateToCheckout,
                      icon: Icons.payment,
                      label: 'Checkout',
                      backgroundColor: Colors.orange,
                    ),
                    const SizedBox(height: 10),
                    StyledButton(
                      onPressed: _goBack,
                      icon: Icons.arrow_back,
                      label: 'Back to Order',
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
