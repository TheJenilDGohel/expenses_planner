import 'dart:io';

import 'package:expense_planner/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void _newTransactionRegister() {
    if (amountController == null) {
      return;
    }
    final submitedTitle = titleController.text;
    final submitedAmount = double.parse(amountController.text);

    if (submitedTitle.isEmpty || submitedAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTransaction(
      submitedTitle,
      submitedAmount,
      _selectedDate,
    );

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2022,
        1,
      ),
      lastDate: DateTime.now(),
    ).then((selectedDatevalue) {
      if (selectedDatevalue == null) {
        return;
      }

      setState(() {
        _selectedDate = selectedDatevalue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
          top: 5,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onSubmitted: (_) => _newTransactionRegister(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              //   onChanged: (value) => titleInput = value,
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _newTransactionRegister(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Choosen !'
                        : 'Picked Date : ${DateFormat().add_yMd().format(_selectedDate!)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),

                  Platform.isIOS
                      ? CupertinoButton(
                          child: Text(
                            "Choose Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _presentDatePicker,
                        )
                      : TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            "Choose Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                  //not working with date picker error
                  // AdaptiveFlatButton(
                  //   text: "Choose Date",
                  //   datePickerHandler: _presentDatePicker,
                  // )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: _newTransactionRegister,
                child: Text('Add Expense'),
                style: ElevatedButton.styleFrom(primary: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
