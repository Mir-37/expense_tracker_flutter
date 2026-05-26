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

  void removeExpenses(Expense ex) {
    final expenseIndex = _registeredExpenses.indexOf(ex);
    setState(() {
      _registeredExpenses.remove(ex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, ex);
            });
          },
        ),
      ),
    );
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
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpenses,
      );
    }
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
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
