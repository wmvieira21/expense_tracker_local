import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    List<Expense> expenses =
        Provider.of<ExpenseProvider>(context, listen: false).expensesList;

    if (expenses.isEmpty) {
      return Center(
        child: Text('No expenses found. Click on + to add expenses'),
      );
    }
    return buildListview(expenses);
  }

  Widget buildListview(List<Expense> expenses) {
    return Consumer<ExpenseProvider>(builder: (context, provider, child) {
      return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: expenses.length,
        itemBuilder: ((context, index) {
          Expense expense = expenses[index];
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
        }),
      );
    });
  }
}
