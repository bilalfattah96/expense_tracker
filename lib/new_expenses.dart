// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAdd});
  final void Function(Expense expense) onAdd;
  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  // var _enteredTitle = '';

  // void _saveTitle(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selecetedDate;
  Category? _selecetedCategory;

  void _selecetedDatefunc() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pikedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: now,
        lastDate: now);
    setState(() {
      _selecetedDate = pikedDate;
    });
  }

  void _submitExpenseData() {
    //'123'
    final enteredAmount = int.tryParse(_amountController.text); //123
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selecetedDate == null) {
      //show error
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid input'),
                content: Text(
                    'Please make sure a valid title,amount, date category was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Okay'),
                  ),
                ],
              ));
      return;
    }
    widget.onAdd(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selecetedDate!,
          category: _selecetedCategory!),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16,48,16,16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text('RS '),
                      label: Text('Amount'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selecetedDate == null
                        ? 'No date selected'
                        : formatter.format(_selecetedDate!)),
                    IconButton(
                        onPressed: _selecetedDatefunc,
                        icon: Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selecetedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      // print(value);
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selecetedCategory = value;
                      });
                    }),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text('Save Expense'),
                ),
              ],
            )
          ],
        ));
  }
}
