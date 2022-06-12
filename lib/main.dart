import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transcation_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {
    initializeDateFormatting('pl_PL');
  }

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

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
    );

    return MaterialApp(
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
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ),
        appBar: AppBar(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(recentTransactions),
              TransactionList(_transactions),
            ],
          ),
        ),
      ),
    );
  }
}
