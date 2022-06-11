import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

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
            TextButton(
              onPressed: submitData,
              style: TextButton.styleFrom(primary: Colors.purple),
              child: Text('Dodaj'),
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

    newTransactionHandler(text, amount);
  }
}
