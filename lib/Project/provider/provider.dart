import 'package:flutter/material.dart';

// import '../../../test/model/product.dart';
import '../model/cart.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  int _totalPrice = 0;

  List<CartItem> get items => [..._items];

  void addToCart(ProductCart product) {
    // Cek apakah produk sudah ada dalam keranjang
    final existingIndex = _items.indexWhere((item) => item.product == product);

    if (existingIndex >= 0) {
      // Jika produk sudah ada, tambahkan quantitynya
      _items[existingIndex].quantity++;
      notifyListeners();
    } else {
      // Jika produk belum ada, tambahkan produk baru dengan quantity 1
      _items.add(CartItem(product, 1));
    }

    notifyListeners();
  }
}
