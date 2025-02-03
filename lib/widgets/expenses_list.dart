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
  _onDeletingExpense(Expense expense) {
    final isExpenseDeleted =
        Provider.of<ExpenseProvider>(context, listen: false)
            .deleteExpense(expense);
    if (isExpenseDeleted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Expense deleted sucessfully!'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  Provider.of<ExpenseProvider>(context, listen: false)
                      .addExpense(expense);
                });
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses =
        Provider.of<ExpenseProvider>(context, listen: false).expensesList;

    if (expenses.isEmpty) {
      return Center(
        child: Text('Click on + button to add your expenses.'),
      );
    }
    return buildListview(expenses);
  }

  Widget buildListview(List<Expense> expenses) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: expenses.length,
      itemBuilder: ((context, index) {
        Expense expense = expenses[index];
        return Dismissible(
          key: ValueKey(expense),
          background: Container(
            margin: Theme.of(context).cardTheme.margin,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.delete, color: Colors.white)),
                ]),
          ),
          onDismissed: (direction) {
            _onDeletingExpense(expense);
          },
          child: Card.outlined(
            color: Theme.of(context).colorScheme.secondaryContainer,
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
  }
}
