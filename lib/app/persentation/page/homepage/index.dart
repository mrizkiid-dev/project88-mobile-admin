import 'package:flutter/material.dart';
import 'package:p88_admin/util/color_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorItem.secondary,
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: ColorItem.primary
          ),
        ),
      ),
    );
  }
}