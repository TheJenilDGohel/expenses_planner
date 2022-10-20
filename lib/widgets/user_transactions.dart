import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransaction = [
    Transaction(
      amount: 10000,
      dateTime: DateTime.now(),
      id: 't1',
      title: '10000 ke shoes hai',
    ),
    Transaction(
      amount: 50000,
      dateTime: DateTime.now(),
      id: 't2',
      title: 'PaaniPuri',
    ),
  ];

  void _addNewTransaction(String txTitle, double txValue) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txValue,
      dateTime: DateTime.now(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        // TransactionList(_userTransaction),
      ],
    );
  }
}
