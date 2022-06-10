import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function(String title, double amount) newTransactionHanlder;

  NewTransaction(this.newTransactionHanlder);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
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
            ),
            TextButton(
              onPressed: () {
                newTransactionHanlder(titleController.text, double.parse(amountController.text));
              },
              style: TextButton.styleFrom(primary: Colors.purple),
              child: Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
