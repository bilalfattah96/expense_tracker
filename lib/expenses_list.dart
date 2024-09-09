import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expense,required this.onRemove});
  final void Function(Expense expense) onRemove;
  final List<Expense> expense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expense[index]),
        onDismissed: (direction) {
          onRemove((expense[index]));
        },
        child: ExpenseItem(expense: expense[index]),
      ),
    );
  }
}