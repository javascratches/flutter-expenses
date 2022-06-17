import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transcation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {}

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Nowe szaty',
      amount: 99.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Hot dog',
      amount: 5.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Majtki',
      amount: 29.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Skarpety',
      amount: 99.99,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );

    final AppBar appBar = AppBar(
      title: const Text(
        'Manager wydatków',
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        )
      ],
    );

    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.amber,
        ),
      ),
      title: 'Manager wydatków',
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ),
        appBar: appBar,
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Wykres'),
                    Switch(
                        value: _showChart,
                        onChanged: (_) {
                          setState(() {
                            _showChart = !_showChart;
                          });
                        }),
                  ],
                ),
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom) *
                      0.6,
                  child: _showChart
                      ? Chart(recentTransactions)
                      : Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top -
                                  MediaQuery.of(context).padding.bottom) *
                              (_showChart ? 0.7 : 1),
                          child: TransactionList(_transactions, _deleteTransaction),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
