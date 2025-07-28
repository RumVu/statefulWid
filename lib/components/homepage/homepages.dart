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
    {
      "name": "Nike Air Max",
      "price": 120.0,
      "qty": 1,
      "image": "assets/images/NikeAirMax270Mens.jpeg",
    },
    {
      "name": "Adidas Ultraboost",
      "price": 150.0,
      "qty": 1,
      "image": "assets/images/giayUltraboost.jpeg",
    },
    {
      "name": "Puma RS-X",
      "price": 100.0,
      "qty": 1,
      "image": "assets/images/giaysneakerpumarsx.jpeg",
    },
  ];

  List<Map<String, dynamic>> productList = [
    {
      "name": "Nike Air Max",
      "price": 120.0,
      "image": "assets/images/NikeAirMax270Mens.jpeg"
    },
    {
      "name": "Adidas Ultraboost",
      "price": 150.0,
      "image": "assets/images/giayUltraboost.jpeg",
    },
    {
      "name": "Puma RS-X",
      "price": 100.0,
      "image": "assets/images/giaysneakerpumarsx.jpeg",
    },
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
      confirmedToDelete.remove(products['name']);
    });
  }

  Future<void> removeFromCart(int index) async {
    if (index >= 0 && index < cart.length) {
      String productName = cart[index]['name'];
      int currentQty = cart[index]['qty'];

      // Nếu số lượng còn nhiều hơn 1 và chưa từng xác nhận → hỏi xác nhận xoá
      if (currentQty > 1 && !confirmedToDelete.contains(productName)) {
        bool? confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Xác nhận xoá'),
            content: Text(
                'Bạn có chắc muốn xoá 1 đơn vị của "$productName" khỏi giỏ hàng không?'),
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

        if (confirm != true) return;
        confirmedToDelete.add(productName); // Ghi nhận đã xác nhận
      }

      // Nếu số lượng > 1 → giảm số lượng
      if (cart[index]['qty'] > 1) {
        setState(() {
          cart[index]['qty'] -= 1;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã giảm 1 đơn vị của $productName.'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
      // Nếu số lượng == 1 → xoá khỏi giỏ luôn
      else {
        setState(() {
          cart.removeAt(index);
          confirmedToDelete.remove(
              productName); // Reset luôn nếu muốn xoá lần nữa phải xác nhận lại
        });
        // ignore: use_build_context_synchronously
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
      body: CustomScrollView(
        slivers: [
          //Gio Hang
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CompoGiohang(
                cart: cart,
                onRemove: removeFromCart,
              ),
            ),
          ),
          //Danh Sách San Pham
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CompoDanhsach(
                productList: productList,
                onAdd: addToCart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
