import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> finalTransactionList;
  final Function deleteTx;

  TransactionList(this.finalTransactionList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return finalTransactionList.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                children: [
                  Text(
                    'No Transactions Avaialble',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          })
        : ListView.builder(
            itemCount: finalTransactionList.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Card(
                elevation: 3,
                borderOnForeground: true,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('₹ ${finalTransactionList[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${finalTransactionList[index].title}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat().format(finalTransactionList[index].dateTime),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(finalTransactionList[index].id),
                  ),
                ),
              ),
            ),
            //   child: Row(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.all(5),
            //         margin: EdgeInsets.symmetric(
            //           vertical: 12,
            //           horizontal: 10,
            //         ),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Theme.of(context).primaryColorDark,
            //             width: 2,
            //           ),
            //         ),
            //         child: Text(
            //           '₹ ${finalTransactionList[index].amount.toStringAsFixed(2)}',
            //           style: Theme.of(context).textTheme.titleMedium,
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             finalTransactionList[index].title,
            //             style: Theme.of(context).textTheme.titleLarge,
            //           ),
            //           Text(
            //             DateFormat.yMEd()
            //                 .format(finalTransactionList[index].dateTime),
            //             style: Theme.of(context).textTheme.titleSmall,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          );
  }
}
