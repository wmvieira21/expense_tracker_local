import 'package:expenses_tracker_coursera/widgets/drawer_menu.dart';
import 'package:expenses_tracker_coursera/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

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
    Navigator.pushNamed(context, '/newExpense');
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
      body: TabBarView(
        controller: _tabController,
        children: [
          ExpensesList(),
          ExpensesList(),
        ],
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
