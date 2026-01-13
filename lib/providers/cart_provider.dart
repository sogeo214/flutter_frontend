import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {}; // productId -> CartItem

  // Get all cart items as a list
  List<CartItem> get items => _items.values.toList();

  // Get total number of items (sum of all quantities)
  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  // Calculate subtotal
  double get subtotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Calculate tax (10% of subtotal)
  double get tax => subtotal * 0.10;

  // Calculate total
  double get total => subtotal + tax;

  // Add product to cart
  void add(Product product) {
    if (_items.containsKey(product.id)) {
      // Increment quantity if product already exists
      _items[product.id] = CartItem(
        product: product,
        quantity: _items[product.id]!.quantity + 1,
      );
    } else {
      // Add new product
      _items[product.id] = CartItem(
        product: product,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  // Remove product from cart
  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Increment product quantity
  void increment(int productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      _items[productId] = CartItem(
        product: item.product,
        quantity: item.quantity + 1,
      );
      notifyListeners();
    }
  }

  // Decrement product quantity
  void decrement(int productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      if (item.quantity > 1) {
        _items[productId] = CartItem(
          product: item.product,
          quantity: item.quantity - 1,
        );
        notifyListeners();
      } else {
        // Remove item if quantity would be 0
        remove(productId);
      }
    }
  }

  // Clear all items from cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Checkout - Call your API
  Future<void> checkout() async {
    // Prepare order data
    final orderItems = _items.values.map((item) => {
      'product_id': item.product.id,
      'quantity': item.quantity,
      'price': item.product.price,
    }).toList();

    // Call the cart service
    await CartService.checkout(
      items: orderItems,
      subtotal: subtotal,
      tax: tax,
      total: total,
    );

    // Clear cart after successful checkout
    clear();
  }
}