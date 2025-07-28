import 'package:flutter/material.dart';
import 'package:statefuwid/components/component_giohang/compo_giohang.dart';
import 'package:statefuwid/components/homepage/homepages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Homepages(), // Gọi ở đây nè
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Widget trung gian để chứa state (vì CompoGioHang là Statefull, nhưng cart nằm ở ngoài)
class GioHangDemoWrapper extends StatefulWidget {
  const GioHangDemoWrapper({super.key});

  @override
  State<GioHangDemoWrapper> createState() => _GioHangDemoWrapperState();
}

class _GioHangDemoWrapperState extends State<GioHangDemoWrapper> {
  List<Map<String, dynamic>> cart = [
    {
      'name': 'Giày Nike',
      'price': 100.0,
      'qty': 1,
    },
    {
      'name': 'Giày Adidas',
      'price': 120.0,
      'qty': 2,
    },
  ];

  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CompoGiohang(
        cart: cart,
        onRemove: removeFromCart,
      ),
    );
  }
}
