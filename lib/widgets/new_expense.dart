import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter_4/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  Category _selectedCategory = Category.leisure;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        (enteredAmount == null || enteredAmount <= 0) ||
        (_selectedDate == null)) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date, and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final Expense expenseItems = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(expenseItems);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Expense added to the list successfully!'),
          ],
        ),
        // backgroundColor: Colors.pinkAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // keyboardType: TextInputType.text, interesting
            maxLength: 55,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    border: OutlineInputBorder(),
                    prefixText: '\$',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Icon(
                        categoryIcons[_selectedCategory],
                      ),
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Add the Date'
                        : formatter.format(
                            _selectedDate!,
                          ), // ! means never be null tell flutter
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () => {
                  // _titleController.text = '',
                  // _amountController.text = '',
                  Navigator.pop(context),
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => {
                  // print(double.tryParse(_amountController.text)),
                  // print(_titleController.text),
                  _submitExpenseData(),
                },
                child: const Text(
                  'Save Expense',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
