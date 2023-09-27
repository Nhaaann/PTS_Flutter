import 'package:new_project/Project/model/cart.dart';

class Carts {
  final List<ProductCart> items = [];

  void addToCart(ProductCart products) {
    items.add(products);
  }
}