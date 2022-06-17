import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Tytuł'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Wartość'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null ? 'Nie wybrano daty' : 'Data: ${DateFormat.yMd('pl_PL').format(_selectedDate!)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDatePicker,
                            child: const Text('Wybierz datę'),
                          )
                        : TextButton(
                            onPressed: _presentDatePicker,
                            child: const Text(
                              'Wybierz datę',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _submitData,
                      child: const Text('Dodaj'),
                    )
                  : ElevatedButton(
                      onPressed: _submitData,
                      child: const Text('Dodaj'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitData() {
    var text = _titleController.text;
    if (text.isEmpty || _amountController.text.isEmpty) {
      return;
    }
    var amount = double.parse(_amountController.text);

    if (amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newTransactionHandler(text, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      locale: Locale('pl', 'PL'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}
