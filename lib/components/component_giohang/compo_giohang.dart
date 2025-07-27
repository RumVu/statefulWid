import 'package:flutter/material.dart';

class CompoGiohang extends StatefulWidget {
  const CompoGiohang({super.key});

  @override
  State<CompoGiohang> createState() => _CompoGiohangState();
}

class _CompoGiohangState extends State<CompoGiohang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(),
    );
  }
}
