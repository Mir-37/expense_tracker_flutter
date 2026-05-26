import 'package:flutter/material.dart';
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
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(249, 248, 73, 132),
              Color.fromARGB(229, 228, 73, 112),
              Color.fromARGB(179, 233, 41, 105),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 12,
          ),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        categoryIcons[expense.category],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        expense.formattedDate,
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
