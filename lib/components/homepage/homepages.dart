import 'dart:math';

import 'package:flutter/material.dart';
import 'package:statefuwid/components/component_danhsach/compo_danhsach.dart';
import 'package:statefuwid/components/component_giohang/compo_giohang.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  Set<String> confirmedToDelete =
      {}; //khai báo nó để dùng chấp nhận xóa lần đầu của sản phẩm đó
  List<Map<String, dynamic>> cart = [
    {"name": "Nike Air Max", "price": 120.0, "qty": 1},
    {"name": "Adidas Ultraboost", "price": 150.0, "qty": 1},
  ];

  List<Map<String, dynamic>> productList = [
    {"name": "Nike Air Max", "price": 120.0},
    {"name": "Adidas Ultraboost", "price": 150.0},
    {"name": "Puma RS-X", "price": 100.0},
  ];

  void addToCart(Map<String, dynamic> products) {
    int index = cart.indexWhere(
      (e) => e['name'] == products['name'],
    );
    setState(() {
      if (index >= 0) {
        // ✅ Nếu sản phẩm đã có → tăng số lượng
        cart[index]['qty'] += 1;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${products['name']} đã được +1 vào giỏ hàng.'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else if (cart.length >= 15) {
        // ✅ Nếu số lượng sản phẩm trong giỏ đã đủ 15
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lấy được tối đa 15 sản phẩm trong giỏ hàng.'),
          ),
        );
      } else {
        // ✅ Kiểm tra nếu sản phẩm hợp lệ và thêm vào
        cart.add({
          "name": products['name'],
          "price": products['price'],
          "qty": 1,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã thêm ${products['name']} vào giỏ hàng.'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });
  }

  Future<void> removeFromCart(int index) async {
    if (index >= 0 && index < cart.length) {
      String productName = cart[index]['name'];

      // Nếu sản phẩm này đã từng xác nhận xoá → xoá thẳng tay
      if (confirmedToDelete.contains(productName)) {
        setState(() {
          cart.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xoá $productName khỏi giỏ hàng.'),
            duration: const Duration(seconds: 1),
          ),
        );
        return;
      }

      // Nếu chưa xác nhận trước đó → hỏi người dùng
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Xác nhận xoá'),
          content:
              Text('Bạn có chắc muốn xoá "$productName" khỏi giỏ hàng không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Huỷ'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Xoá', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirm == true) {
        // ✅ Ghi nhận sản phẩm đã xác nhận xoá
        confirmedToDelete.add(productName);

        setState(() {
          cart.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xoá $productName khỏi giỏ hàng.'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } else {
      debugPrint('Index không hợp lệ: $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoe Store',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),

      // body: CustomScrollView(
      //   slivers: [
      //     //Gio Hang
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: const EdgeInsets.all(10),
      //         child: CompoGiohang(
      //             // cart: cart,
      //             // onRemove: removeFromCart,
      //             ),
      //       ),
      //     ),
      //     //Danh Sách San Pham
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: const EdgeInsets.all(10),
      //         child: CompoDanhsach(
      //             // productList: productList,
      //             // onAdd: addToCart,
      //             ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
