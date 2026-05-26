import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/widgets/chart/chart.dart';
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
        duration: Duration(milliseconds: 1200),
        persist: false,
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
      title: 'Burger at BFC',
      amount: 190,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Ciggarettes during break',
      amount: 120,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Chanda at work',
      amount: 130,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Rickshaw to work',
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
    Widget mainContent = Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: Theme.of(context).textTheme.headlineMedium,
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
        centerTitle: true,
        title: const Text(
          'ExpenseTracker',
          style: TextStyle(
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          Icon(
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Chart(expenses: _registeredExpenses),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                'Expense Bucket',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
