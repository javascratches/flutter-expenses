import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
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
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.purpleAccent,
      Colors.blueAccent,
      Colors.amberAccent,
      Colors.greenAccent,
      Colors.deepPurpleAccent,
      Colors.indigoAccent,
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Dismissible(
        key: Key(widget.tx.id),
        onDismissed: (_) {
          widget.deleteTransactionHandler(widget.tx.id);
        },
        background: Container(
          color: Theme.of(context).errorColor,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text('${widget.tx.amount.toStringAsFixed(2)} zł'),
              ),
            ),
          ),
          title: Text(
            widget.tx.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            DateFormat.yMMMMd('pl_PL').format(widget.tx.date),
          ),
          trailing: widget.mediaQuery.size.width > 360
              ? TextButton.icon(
                  onPressed: () => widget.deleteTransactionHandler(widget.tx.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Usuń'),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    widget.deleteTransactionHandler(widget.tx.id);
                  },
                ),
        ),
      ),
    );
  }
}
