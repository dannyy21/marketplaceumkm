import 'package:flutter/material.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Page")),
      body: const Center(child: Text("QR Code Scanner")),
    );
  }
}
