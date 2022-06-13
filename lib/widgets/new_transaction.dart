import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Tytuł'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Wartość'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  const Text('Nie wybrano daty'),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Wybierz datę',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }

  void submitData() {
    var text = titleController.text;
    var amount = double.parse(amountController.text);

    if (text.isEmpty || amount <= 0) {
      return;
    }

    widget.newTransactionHandler(text, amount);

    Navigator.of(context).pop();
  }
}
