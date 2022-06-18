import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tx,
    required this.deleteTransactionHandler,
    required this.mediaQuery,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTransactionHandler;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Dismissible(
        key: Key(tx.id),
        onDismissed: (_) {
          deleteTransactionHandler(tx.id);
        },
        background: Container(
          color: Theme.of(context).errorColor,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text('${tx.amount.toStringAsFixed(2)} zł'),
              ),
            ),
          ),
          title: Text(
            tx.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            DateFormat.yMMMMd('pl_PL').format(tx.date),
          ),
          trailing: mediaQuery.size.width > 360
              ? TextButton.icon(
            onPressed: () => deleteTransactionHandler(tx.id),
            icon: const Icon(Icons.delete),
            label: const Text('Usuń'),
          )
              : IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () {
              deleteTransactionHandler(tx.id);
            },
          ),
        ),
      ),
    );
  }
}