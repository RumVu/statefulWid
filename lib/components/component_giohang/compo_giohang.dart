import 'package:flutter/material.dart';

class CompoGiohang extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int) onRemove;
  const CompoGiohang({super.key, required this.cart, required this.onRemove});

  @override
  State<CompoGiohang> createState() => _CompoGiohangState();
}

class _CompoGiohangState extends State<CompoGiohang> {
  double get total =>
      widget.cart.fold(0, (sum, item) => sum + item['price'] * item['qty']);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Giỏ hàng",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (widget.cart.isEmpty)
          const Center(
            child: Text(
              "Chưa có sản phẩm nào trong giỏ hàng.",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          )
        else
          ...widget.cart.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image'],
                        width: 100,
                        height: 115,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      )),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text("Giá: ${item['price']} \$",
                            style: const TextStyle(color: Colors.green)),
                        Text("Số lượng: ${item['qty']}",
                            style: const TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => widget.onRemove(index),
                  ),
                ],
              ),
            );
          }),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Tổng tiền: ${total.toStringAsFixed(2)} \$",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
