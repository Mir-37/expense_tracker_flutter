import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/models/expense.dart';
import 'package:udemy_flutter_4/widgets/chart/chart.dart';
import 'package:udemy_flutter_4/widgets/chart/pie.dart';

class OverviewAndExpensesDesktop extends StatelessWidget {
  const OverviewAndExpensesDesktop({
    super.key,
    required this.mainContent,
    required this.registeredExpenses,
  });

  final Widget mainContent;
  final List<Expense> registeredExpenses;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Chart(expenses: registeredExpenses),
              ),
              Expanded(
                child: Pie(expenses: registeredExpenses),
              ),
            ],
          ),
        ),
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: mainContent,
        ),
      ],
    );
  }
}
