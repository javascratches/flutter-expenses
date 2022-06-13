import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('${spendingAmount.toStringAsFixed(0)} zł'),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 200, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingOfTotal,
                child: Container(
                    decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
