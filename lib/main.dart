import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transcation_list.dart';

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

    Widget _buildCupertinoNavigationBar() {
      return CupertinoNavigationBar(
        middle: const Text('Manager wydatków'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Builder(
                builder: (context) => GestureDetector(
                      onTap: () => _startAddNewTransaction(context),
                      child: const Icon(CupertinoIcons.add),
                    ))
          ],
        ),
      );
    }

    Widget _buildAppBar() {
      return AppBar(
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
    }

    final dynamic appBar = Platform.isIOS ? _buildCupertinoNavigationBar() : _buildAppBar();

    final transactionList = Builder(builder: (context) {
      return SizedBox(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom) *
                (_showChart ? 0.7 : 1),
        child: TransactionList(_transactions, _deleteTransaction),
      );
    });

    List<Widget> _buildLandscapeContent(BuildContext context) {
      var mediaQuery = MediaQuery.of(context);
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Wykres'),
            Switch.adaptive(
              value: _showChart,
              onChanged: (_) => setState(() => _showChart = !_showChart),
            )
          ],
        ),
        SizedBox(
          height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - mediaQuery.padding.bottom) * 0.6,
          child: _showChart ? Chart(recentTransactions) : transactionList,
        )
      ];
    }

    List<Widget> _buildPortraitContent(BuildContext context) {
      return [
        SizedBox(
          height:
              (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom) *
                  0.3,
          child: Chart(recentTransactions),
        ),
        transactionList,
      ];
    }

    final pageBody = OrientationBuilder(
      builder: (context, orientation) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (orientation == Orientation.landscape) ..._buildLandscapeContent(context),
              if (orientation != Orientation.landscape) ..._buildPortraitContent(context),
            ],
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoApp(
            title: 'Manager wydatków',
            localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
            home: CupertinoPageScaffold(
              navigationBar: appBar,
              child: pageBody,
            ))
        : MaterialApp(
            localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
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
              body: pageBody,
            ),
          );
  }
}
