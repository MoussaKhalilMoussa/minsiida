import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("filters"),
      ),
      body: Center(
        child: Text("data"),
      ),
    );
  }
}