import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double percentageOfTotal;

  ChartBar({
    required this.label,
    required this.amountSpent,
    required this.percentageOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: [
          Container(
            height: constrains.maxHeight * 0.13,
            child: FittedBox(
                child: Text(
              '₹ ${amountSpent.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constrains.maxHeight * 0.65,
            width: 13,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constrains.maxHeight * 0.11,
            child: FittedBox(
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    });
  }
}
