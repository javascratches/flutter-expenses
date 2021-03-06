import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler) {
    print('Constructor NewTransaction widget');
  }

  @override
  State<NewTransaction> createState() {
    print('createState NewTransaction widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    print('initState())');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget())');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose())');
    super.dispose();
  }

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
                decoration: const InputDecoration(labelText: 'Tytuł'),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Wartość'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null ? 'Nie wybrano daty' : 'Data: ${DateFormat.yMd('pl_PL').format(_selectedDate!)}'),
                    ),
                    AdaptiveButton(_presentDatePicker, 'Wybierz datę')
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
      locale: const Locale('pl', 'PL'),
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
