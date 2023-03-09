import 'package:flutter/material.dart';

import '../Widget/BalanceCard.dart';
import '../Widget/buttomnavbar.dart';
import '../Widget/topnavigationbar.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _balance = 0.0;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final balanceResponse = await http
        .get(Uri.parse('http://localhost:8081/api/v1/wallet/get/va137909'));
    final transactionResponse = await http.get(
        Uri.parse('http://localhost:8082/api/v1/transaction/all/va137909'));

    setState(() {
      _balance = jsonDecode(balanceResponse.body)['wallet']['balance'];
      _transactions = List<Transaction>.from(
          jsonDecode(transactionResponse.body)
              .map((transaction) => Transaction.fromJson(transaction))
              .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BanklyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceCard(balance: _balance),
            SizedBox(height: 16.0),
            Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_transactions[index].transactionType),
                    subtitle: Text(
                        '\$${_transactions[index].transactionAmount} - ${_transactions[index].transactionDate}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class Transaction {
  final int id;
  final String govId;
  final String transactionType;
  final double transactionAmount;
  final String transactionDate;
  final String transactionStatus;

  Transaction({
    required this.id,
    required this.govId,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionStatus,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    print(json);
    return Transaction(
      id: json['id'],
      govId: json['govId'],
      transactionType: json['transactionType'],
      transactionAmount: double.parse(json['transactionAmount']),
      transactionDate: json['transactionDate'],
      transactionStatus: json['transactionStatus'],
    );
  }
}
