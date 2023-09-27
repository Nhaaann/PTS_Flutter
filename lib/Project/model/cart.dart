// import 'package:new_project/UTS/test/model/product.dart';

class ProductCart {
  final String images;
  final String textDesc;
  final int harga;
  final String subDesc;
  int quantity;

  ProductCart(
      {required this.images,
      required this.textDesc,
      required this.harga,
      required this.subDesc,
      this.quantity = 1
      });
}

class CartItem {
  final ProductCart product;
  int quantity;

  CartItem(this.product, this.quantity);
}
