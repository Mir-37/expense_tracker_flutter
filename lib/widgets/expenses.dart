import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/widgets/expenses_list/expenses_list.dart';
import 'package:udemy_flutter_4/models/expense.dart';
import 'package:udemy_flutter_4/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void registerExpense(Expense ex) {
    setState(() {
      _registeredExpenses.add(ex);
    });
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter hello',
      amount: 190,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Flutter hello 2',
      amount: 120,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Flutter hello 3',
      amount: 130,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Flutter hello 4',
      amount: 140,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: registerExpense,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
