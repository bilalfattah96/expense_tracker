import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Web Course',
        amount: 1000,
        date: DateTime.now(),
        category: Category.course),
    Expense(
        title: 'Burger',
        amount: 500,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Burger',
        amount: 500,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Burger',
        amount: 500,
        date: DateTime.now(),
        category: Category.travel),
  ];

void _openModal(){
  showModalBottomSheet(context: context, builder: (ctx)=> NewExpenses());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:_openModal ,
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Text('The Chart'),
          // Text('Expense List'),
          Expanded(
            child: ExpensesList(
              expense: _registeredExpenses,
            ),
          )
        ],
      ),
    );
  }
}
