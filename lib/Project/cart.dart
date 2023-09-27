// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_project/Project/model/cart.dart';
import 'package:new_project/Project/provider/provider.dart';
import 'package:provider/provider.dart';

import 'gtau/rawr.dart';

class CartPageUts extends StatefulWidget {
  // final String images;
  // final String textDesc;
  // final int harga;
  final ProductCart products;
  final Carts carts;

  CartPageUts({
    // required this.images,
    // required this.textDesc,
    // required this.harga,
    required this.products,
    required this.carts,
  });

  @override
  State<CartPageUts> createState() => _CartPageUtsState();
}

class _CartPageUtsState extends State<CartPageUts> {
  int harga_awal = 0;
  int index_awal = 1;

  @override
  void initState() {
    super.initState();

    // Initialize harga_awal with the sum of prices of all products in the cart
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    harga_awal = cartProvider.items.fold(0, (sum, cartItem) {
      return sum + (cartItem.product.harga * cartItem.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
          child: Column(
            children: [
              _Header(context),
              SizedBox(height: 32),
              _Jumbotron(),
              SizedBox(height: 24),
              Barang2(context, screenWidth),
              SizedBox(height: 82),
              Harga_2(screenWidth, harga_awal)
            ],
          ),
        ),
      ),
    );
  }

  Widget Barang2(BuildContext context, screenWidth) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      width: screenWidth,
      height: 300,
      child: ListView.builder(
        itemCount: cartProvider.items.length,
        itemBuilder: (context, index) {
          final cartItem = cartProvider.items[index];
          final product = cartItem.product;
          int hargaProduk = product.harga;

          return Container(
            margin: EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(product.images, width: 100, height: 100),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          width: screenWidth / 3,
                          child: Text(
                            product.textDesc,
                            style: GoogleFonts.inter(
                              color: Color(0xff292D32),
                              fontSize: 16,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Menambahkan elipsis jika teks terlalu panjang
                            maxLines: 1,
                          ),
                        ),
                        // SizedBox(height: 6),
                        Container(
                          width: screenWidth / 3,
                          child: Text(
                            product.subDesc,
                            style: GoogleFonts.inter(
                                color: Color(0xff292D32).withOpacity(0.7),
                                fontSize: 12.8,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: screenWidth / 3,
                          child: Text(
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp.',
                                    decimalDigits: 0)
                                .format(product.harga)
                                .toString(),
                            style: GoogleFonts.inter(
                              color: Color(0xff292D32),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(),/
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffF2F2F7),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity > 0) {
                                setState(() {
                                  cartItem.quantity--;
                                  // harga_awal = hargaProduk;
                                  harga_awal = harga_awal - hargaProduk;
                                });
                              }
                            },
                            child: Icon(
                              Iconsax.minus,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text((cartItem.quantity).toString()),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                cartItem.quantity++;
                                harga_awal = harga_awal + hargaProduk;
                              });
                            },
                            child: Icon(
                              Iconsax.add,
                              size: 20,
                              color: Color(0xff00B14F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget Harga_2(double screenWidth, int hargaAwal) {
    final cartProvider = Provider.of<CartProvider>(context);
    // if (widget.products.harga == 1) {
    //   hargaAwal = widget.products.harga;
    // }
    // final product = cartProvider.items[index];

    return Container(
      width: screenWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32).withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                '${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0).format(harga_awal)}',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongkir',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32).withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp.14.000',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32).withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                '${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0).format(14000 + harga_awal)}',
                style: GoogleFonts.inter(
                  color: Color(0xff292D32),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 24),
          Container(
            margin: EdgeInsets.only(bottom: 18),
            height: 50,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Color(0xff00B14F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: Text(
                'Tambah Keranjang',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        // Tambahkan harga produk yang baru ke harga_awal
        harga_awal +=
            (widget.products.harga * 1); // 1 adalah jumlah yang ditambahkan
        // ... kode lainnya ...

        return AlertDialog(
          title: Text('Sukses'),
          content: Text('Success menambahkan ke keranjang'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  Container _Jumbotron() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Wrap(
                children: [
                  Icon(
                    Iconsax.location,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dikirim ke',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0xff292D32).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Jakarta, Cibubur, Kota Wisata \nMadrid No 23',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff292D32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            'ubah',
            style: GoogleFonts.inter(
              color: Color(0xff00B14F),
            ),
          )
        ],
      ),
    );
  }

  Row _Header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Iconsax.arrow_left,
            size: 26,
          ),
        ),
        Text(
          'Keranjang',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xff292D32)),
        ),
        Image.asset('assets/more-horizontal 2.png')
      ],
    );
  }
}
