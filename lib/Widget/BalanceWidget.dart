import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final double balance;
  final String lastTransaction;

  const BalanceWidget({Key? key, required this.balance, required this.lastTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Balance: \$${balance.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        Text(
          'Last Transaction: $lastTransaction',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
