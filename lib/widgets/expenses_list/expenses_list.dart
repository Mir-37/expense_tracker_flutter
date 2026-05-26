import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/models/expense.dart';
import 'package:udemy_flutter_4/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(
        expenses[index],
      ),
    );
  }
}
