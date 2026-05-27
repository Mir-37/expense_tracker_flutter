import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:udemy_flutter_4/models/expense.dart';

class Pie extends StatefulWidget {
  const Pie({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<Pie> createState() => _PieState();
}

class _PieState extends State<Pie> {
  int touchedIndex = -1;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(widget.expenses, Category.food),
      ExpenseBucket.forCategory(widget.expenses, Category.leisure),
      ExpenseBucket.forCategory(widget.expenses, Category.travel),
      ExpenseBucket.forCategory(widget.expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  double get totalExpensesSum {
    double sum = 0;

    for (final bucket in buckets) {
      sum += bucket.totalExpenses;
    }

    return sum;
  }

  List<PieChartSectionData> getSections(BuildContext context) {
    List<PieChartSectionData> data = [];

    List<Color> colors = [
      Colors.amberAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.redAccent,
    ];

    int i = 0;

    for (final bucket in buckets) {
      final index = i;

      final percentage = (bucket.totalExpenses / totalExpensesSum) * 100;

      final isTouched = index == touchedIndex;

      data.add(
        PieChartSectionData(
          value: bucket.totalExpenses == 0
              ? 0
              : bucket.totalExpenses / maxTotalExpense,
          color: colors[i++],

          title: '${bucket.category.name} ${percentage.round()}%',

          titleStyle: Theme.of(context).textTheme.titleSmall,

          titlePositionPercentageOffset: 0.67,

          radius: isTouched ? 150 : 130,

          badgeWidget: Icon(
            categoryIcons[bucket.category],
            size: 20,
            color: Colors.black,
          ),

          badgePositionPercentageOffset: 1.2,
        ),
      );
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,

          sections: getSections(context),

          startDegreeOffset: 160,

          pieTouchData: PieTouchData(
            enabled: true,
            touchCallback: (event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }

                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
        ),

        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    );
  }
}
