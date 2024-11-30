import 'package:flutter/material.dart';

class AddCashFlow extends StatefulWidget {
  const AddCashFlow({super.key});

  @override
  State<AddCashFlow> createState() => _AddCashFlowState();
}

class _AddCashFlowState extends State<AddCashFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text('Aqui tu adiciona'),
    );
  }
}
