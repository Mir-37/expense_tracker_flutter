import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/models/expense.dart';
import 'package:udemy_flutter_4/widgets/chart/chart.dart';
import 'package:udemy_flutter_4/widgets/chart/pie.dart';

class OverviewAndExpensesMobile extends StatelessWidget {
  const OverviewAndExpensesMobile({
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
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Chart(expenses: registeredExpenses),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Pie(expenses: registeredExpenses),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scroll ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
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
