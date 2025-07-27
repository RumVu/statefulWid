import 'package:flutter/material.dart';

class CompoDanhsach extends StatefulWidget {
  const CompoDanhsach({super.key});

  @override
  State<CompoDanhsach> createState() => _CompoDanhsachState();
}

class _CompoDanhsachState extends State<CompoDanhsach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(),
    );
  }
}
