import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    initializeDateFormatting('pl_PL');
  }

  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'Nowe szaty',
      amount: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Hot dog',
      amount: 5.99,
      date: DateTime.now(),
    ),
  ];

  String? titleInput;
  String? amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Text('Lorem'),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Tytuł'),
                      onChanged: (value)  {
                       titleInput = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Wartość'),
                      onChanged: (value) => amountInput = value,
                    ),
                    TextButton(
                      onPressed: () {
                        print(titleInput);
                        print(amountInput);
                      },
                      style: TextButton.styleFrom(primary: Colors.purple),
                      child: Text('Dodaj'),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ...(transactions.map((tx) {
                  return Card(
                    elevation: 8,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            '${tx.amount} zł',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(tx.date),
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
