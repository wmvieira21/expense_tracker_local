import 'package:collection/collection.dart';
import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';
import 'package:expenses_tracker_coursera/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesGrouped extends StatelessWidget {
  const ExpensesGrouped({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> totalAmountByCategory = {};
    List<Expense> expenses =
        Provider.of<ExpenseProvider>(context, listen: true).expensesList;

    Map<String, List<Expense>> expensesGrouped =
        expenses.groupListsBy((element) => element.categoryId);

    expensesGrouped.forEach((categoria, expenses) {
      double totalAmout = expenses.fold<double>(
          0, (previousValue, element) => previousValue += element.amount);
      totalAmountByCategory[categoria] = totalAmout;
    });

    if (expenses.isEmpty) {
      return Center(
        child: Text('Click on + button to add your expenses.'),
      );
    }

    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: expensesGrouped.length,
        itemBuilder: (context, indexMap) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${expensesGrouped.keys.elementAt(indexMap)} - Total: \$${totalAmountByCategory[expensesGrouped.keys.elementAt(indexMap)]}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                ...expensesGrouped.values.elementAt(indexMap).map((item) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      '${item.payee} - \$${item.amount}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    subtitle: Text(
                      converter.format(item.date),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  );
                })
              ]);
        });
  }
}
