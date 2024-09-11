import 'package:expense_tracker/chart/chart.dart';
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
    // Expense(
    //     title: 'Burger',
    //     amount: 500,
    //     date: DateTime.now(),
    //     category: Category.food),
    // Expense(
    //     title: 'Burger',
    //     amount: 500,
    //     date: DateTime.now(),
    //     category: Category.work),
    // Expense(
    //     title: 'Burger',
    //     amount: 500,
    //     date: DateTime.now(),
    //     category: Category.travel),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final enpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registeredExpenses.insert(enpenseIndex, expense);
          });
        }),
      ),
    );
  }

  void _openModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(
              onAdd: _addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No Expense Found'),
    );
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
              expense: _registeredExpenses,
              onRemove: _removeExpense,
            );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openModal,
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          // Text('The Chart'),
          // Text('Expense List'),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
