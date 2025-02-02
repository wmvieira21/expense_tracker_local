import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<Expense> expensesDummyList = [
    Expense(
        amount: 11,
        categoryId: 'categoryId',
        payee: 'payee',
        note: 'note',
        date: DateTime.now(),
        tag: 'tag'),
    Expense(
        amount: 1222,
        categoryId: 'sdsd',
        payee: 'dddd',
        note: 'note',
        date: DateTime.now(),
        tag: 'tag'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: expensesDummyList.length,
        itemBuilder: ((context, index) {
          Expense expense = expensesDummyList[index];
          return Dismissible(
            key: ValueKey(expense),
            child: Card.outlined(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: Container(
                padding: EdgeInsets.all(16),
                height: 100,
                child: Column(spacing: 10, children: [
                  Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(expense.payee),
                      Text('\$${expense.amount}'),
                    ],
                  ),
                  Row(
                    spacing: 15,
                    children: [
                      Text(expense.formattedDate),
                      Text('Category: ${expense.categoryId}'),
                    ],
                  ),
                ]),
              ),
            ),
          );
        }));
  }
}
