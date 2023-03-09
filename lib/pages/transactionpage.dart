import 'package:flutter/material.dart';

import '../Widget/buttomnavbar.dart';
import '../Widget/topnavigationbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController amountController = TextEditingController();
  String? transactionType;

  void createTransaction() async {
    final url = Uri.parse('http://localhost:8082/api/v1/transaction/create');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'govId': 'va137909',
      'amount': amountController.text,
      'transactionType': transactionType,
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // handle success
      Navigator.pushNamed(context, '/home');
    } else {
      // handle error
    }
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
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: transactionType,
              onChanged: (value) {
                setState(() {
                  transactionType = value;
                });
              },
              items: [
                DropdownMenuItem(child: Text('Deposit'), value: 'deposit'),
                DropdownMenuItem(child: Text('Withdraw'), value: 'withdraw'),
              ],
              decoration: InputDecoration(labelText: 'Transaction Type'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createTransaction,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      );
  }
}
