import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'Nie zarejestrowano jeszcze żadnych wydatków',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                        key: Key(tx.id),
                        tx: tx,
                        deleteTransactionHandler: deleteTransactionHandler,
                        mediaQuery: mediaQuery,
                      ))
                  .toList()),
    );
  }
}
