import 'package:expenses/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    initializeDateFormatting('pl_PL');
  }

  String? titleInput;
  String? amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: new Icon(Icons.add),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
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
              UserTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}
