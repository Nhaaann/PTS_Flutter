// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:new_project/Project/cart.dart';
import 'package:new_project/Project/detail.dart';
import 'package:new_project/Project/gtau/rawr.dart';
import 'package:new_project/Project/model/cart.dart';
import 'package:new_project/Project/provider/provider.dart';

class HomePageUts extends StatefulWidget {
  @override
  State<HomePageUts> createState() => _HomePageUtsState();
}

class _HomePageUtsState extends State<HomePageUts> {
  @override
  int selcetindex = 0;
  int _selectedIndex = 0; // Indeks item yang dipilih

  // Daftar warna yang sesuai dengan item yang dipilih atau tidak dipilih
  List<Color> itemColors = [
    Color(0xff00B14F),
    Colors.black87,
    Colors.black87,
    Colors.black87
  ];
  BottomNavigationBar _BtmNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: itemColors[_selectedIndex],
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.heart),
          label: 'Favorit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.task_square),
          label: 'Transaksi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profil',
        ),
      ],
      unselectedItemColor: Colors.black87,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Mengubah warna item yang dipilih menjadi warna yang diinginkan
      for (int i = 0; i < itemColors.length; i++) {
        itemColors[i] = i == index ? Color(0xff00B14F) : Colors.black87;
      }
    });
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        actions: [
          Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: screenWidth,
              child: _Header(
                  screenWidth, 'assets/Rectangle 4.png', '', 399000, ''),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 24),
              _Isi1(screenWidth),
              SizedBox(height: 24),
              _Option(),
              SizedBox(height: 24),
              _Cards(context),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BtmNav(),
    );
  }

  Column _Cards(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(context, 'assets/Rectangle 4.png',
                'Batik Pria Lengan \nPanjang', 199000, 'Xl'),
            SizedBox(width: 14),
            Card(context, 'assets/Rectangle 4 (1).png',
                'New Balance 992 Grey Original', 1240000, '40'),
          ],
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(context, 'assets/Rectangle 4 (2).png',
                'Skinny Jeans Dark Blue Wanita', 379900, 'M'),
            SizedBox(width: 14),
            Card(context, 'assets/Rectangle 4 (3).png',
                'Kacamata Baca Anti Radiasi Blue Ray', 125000, '-2, Hitam'),
          ],
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(context, 'assets/Rectangle 4 (4).png',
                'Kemeja Pria Polos Lengan Pendek Oxford', 199000, 'Xl, Hitam'),
            SizedBox(width: 14),
            Card(context, 'assets/Rectangle 4 (5).png',
                'Human Greatness Hoodie Hitam', 229000, 'Xl, Hitam'),
          ],
        ),
      ],
    );
  }

  Widget Card(BuildContext context, String img, String judul, int harga,
      String subDesc) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailPapgeUts(
              images: img,
              textDesc: judul,
              harga: harga,
              carts: Carts(),
              products: ProductCart(
                  images: img, textDesc: judul, harga: harga, subDesc: subDesc),
            );
          },
        ));
      },
      child: Container(
        width: screenWidth / 2.4,
        height: 264,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // image: DecorationImage(
          //   image: AssetImage(img),
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(img, fit: BoxFit.cover),
            SizedBox(height: 12),
            Text(
              judul,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
                  .format(harga)
                  .toString(),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _Option() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kategori',
              style: GoogleFonts.inter(
                color: Color(0xff292D32),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Lihat semua',
              style: GoogleFonts.inter(
                color: Color(0xff00B14F),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Content(0, 'Semua'),
              Content(1, 'Kemeja'),
              Content(2, 'Sepatu'),
              Content(3, 'Aksesoris'),
            ],
          ),
        ),
      ],
    );
  }

  Widget Content(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selcetindex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        margin: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selcetindex == index ? Color(0xff00B14F) : Colors.white,
          border: Border.all(color: Color(0xffF2F2F7), width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: selcetindex == index
                  ? Colors.white
                  : Color.fromARGB(78, 41, 45, 50),
            ),
          ),
        ),
      ),
    );
  }

  Container _Isi1(double screenWidth) {
    return Container(
      width: screenWidth,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/Banner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Row _Header(
      double screenWidth, String img, String judul, int harga, String subDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(right: 14, left: 14, top: 5),
          width: screenWidth / 1.55,
          decoration: BoxDecoration(
              color: Color(0xffF2F2F7),
              borderRadius: BorderRadius.circular(16)),
          child: TextFormField(
            style: GoogleFonts.openSans(color: Colors.black54),
            decoration: InputDecoration(
              hintText: 'Cari pakaian Pria',
              hintStyle:
                  GoogleFonts.openSans(color: Color.fromARGB(121, 41, 45, 50)),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 5),
                child: Icon(
                  Iconsax.search_normal_1,
                  size: 24,
                  color: Color(0xff292D32),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Iconsax.notification,
              size: 26,
              color: Color(0xff292D32),
            ),
            SizedBox(width: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CartPageUts(
                        products: ProductCart(
                          images: img,
                          textDesc: judul,
                          harga: harga,
                          subDesc: subDesc,
                        ),
                        carts: Carts(),
                      );
                    },
                  ),
                );
              },
              child: Icon(
                Iconsax.bag,
                size: 26,
                color: Color(0xff292D32),
              ),
            ),
          ],
        )
      ],
    );
  }
}
