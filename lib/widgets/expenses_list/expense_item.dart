import 'package:flutter/material.dart';
import 'package:udemy_flutter_4/main.dart';
import 'package:udemy_flutter_4/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kColorScheme.surfaceTint,
              spreadRadius: 0.7,
              blurRadius: 0.3,
              offset: Offset.fromDirection(1.0),
            ),
          ],
          // gradient: LinearGradient(
          //   colors: [
          //     kColorScheme.tertiaryFixedDim.withAlpha(95),
          //     // kColorScheme.secondaryFixedDim.withAlpha(55),
          //     kColorScheme.tertiaryFixedDim.withAlpha(150),
          //   ],
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 12,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Spacer(),
                  Icon(
                    categoryIcons[expense.category],
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    expense.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    'Spent: \$${expense.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 25,
                  ),

                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'Spent at: ${expense.formattedDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
