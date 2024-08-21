import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('RS ' + expense.amount.toString()),
                Spacer(),
                Row(
                  children: [
                    // Icon(Icons.alarm),
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 8,),
                    // Text('${expense.date.day}-${expense.date.month}-${expense.date.year}')
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
