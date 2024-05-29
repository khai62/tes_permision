import 'package:flutter/material.dart';

class TroliScreen extends StatelessWidget {
  const TroliScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Troli Screen'),
      ),
      body: Center(
        child: Text('Troli Page'),
      ),
    );
  }
}