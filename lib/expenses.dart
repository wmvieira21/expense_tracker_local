import 'package:expenses_tracker_coursera/models/category.dart';
import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:expenses_tracker_coursera/providers/category_provider.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';
import 'package:expenses_tracker_coursera/providers/tag_provider.dart';
import 'package:expenses_tracker_coursera/screens/add_expense.dart';
import 'package:expenses_tracker_coursera/widgets/drawer_menu.dart';
import 'package:expenses_tracker_coursera/widgets/expenses_grouped.dart';
import 'package:expenses_tracker_coursera/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'By Date'),
    Tab(text: 'By Category'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _selectPageDrawer(int indexTab) {
    Navigator.of(context).pop();
    if (indexTab == 0) {
      Navigator.pushNamed(context, '/categories');
    } else {
      Navigator.pushNamed(context, '/tags');
    }
  }

  void _addExpense() {
    List<Tag> tags = Provider.of<TagProvider>(context, listen: false).tagsList;
    List<Category> categories =
        Provider.of<CategoryProvider>(context, listen: false).categoriesList;

    if (categories.isEmpty || tags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Tags or Categories not found.'),
        ),
      );
    } else {
      String categoryInitialValue = categories[0].name;
      String tagInitialValue = tags[0].name;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddExpense(
            categories: categories,
            tags: tags,
            initiaCategoryValue: categoryInitialValue,
            initiaTagValue: tagInitialValue,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: [...myTabs],
        ),
        title: Text('Expense Tracker',
            style: Theme.of(context).textTheme.headlineSmall),
        //toolbarHeight: 50,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, value, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              ExpensesList(),
              ExpensesGrouped(),
            ],
          );
        },
      ),
      drawer: DrawerMenu(
          selectedItemDrawer: (indexTab) => _selectPageDrawer(indexTab)),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new expense',
        onPressed: _addExpense,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
