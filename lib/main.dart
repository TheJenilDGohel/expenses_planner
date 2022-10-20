import 'dart:io';

import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(Object context) {
    return MaterialApp(
      title: 'Expense Planner',
      home: MyHomePage(),
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        primarySwatch: Colors.pink,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Cairo',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   amount: 10000,
    //   dateTime: DateTime.now(),
    //   id: 't1',
    //   title: '10000 ke shoes hai',
    // ),
    // Transaction(
    //   amount: 50000,
    //   dateTime: DateTime.now(),
    //   id: 't2',
    //   title: 'PaaniPuri',
    // ),
  ];

  List<Transaction> get _recentTransactions => _userTransaction
      .where(
        (tx) => tx.dateTime.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        ),
      )
      .toList();

  void _addNewTransaction(String txTitle, double txValue, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txValue,
      dateTime: txDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _addTransactionDailoug(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: ((_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      }),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  late bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iosAppBar = CupertinoNavigationBar(
      middle: Text("Expenses Tracker"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _addTransactionDailoug(context),
            child: Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );
    final PreferredSizeWidget appBar = AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(
          onPressed: () => _addTransactionDailoug(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );
    final mainBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Graph',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch.adaptive(
                    focusColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: ((value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.6,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: iosAppBar,
            child: mainBody,
          )
        : Scaffold(
            appBar: appBar,
            body: mainBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _addTransactionDailoug(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
