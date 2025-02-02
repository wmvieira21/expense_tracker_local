import 'dart:convert';

import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ExpenseProvider extends ChangeNotifier {
  ExpenseProvider({required this.storage}) {
    _loadExpensesLocalStorage();
  }
  LocalStorage storage;
  List<Expense> _expenses = [];

  _loadExpensesLocalStorage() {
    String? expensesJson = storage.getItem('expenses');
    if (expensesJson != null) {
      _expenses = List.from(
        (jsonDecode(expensesJson) as List).map(
          (element) => Expense.fromJson(element),
        ),
      );
      notifyListeners();
    }
  }

  addExpense(Expense expense) {
    try {
      _expenses.add(expense);
      List<Map<String, dynamic>> json =
          _expenses.map((expense) => expense.toJson()).toList();

      storage.setItem(
        'expenses',
        jsonEncode(json),
      );
      notifyListeners();
    } catch (e) {
      print('Error during JSON encoding: $e');
    }
  }

  List<Expense> get expensesList {
    return _expenses;
  }
}
