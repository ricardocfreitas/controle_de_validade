import 'package:flutter/material.dart';
import 'ui/home_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ProdutosVencidosPage());
  }
}
