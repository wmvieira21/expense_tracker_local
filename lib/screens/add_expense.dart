import 'package:expenses_tracker_coursera/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_tracker_coursera/utils.dart';
import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.categories,
    required this.tags,
    required this.initiaCategoryValue,
    required this.initiaTagValue,
  });

  final List<Tag> tags;
  final List<Category> categories;
  final String initiaCategoryValue;
  final String initiaTagValue;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _payeeController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedDate = converter.format(DateTime.now());
  String categoryValue = '';
  String tagValue = '';

  @override
  void initState() {
    super.initState();
    categoryValue = widget.initiaCategoryValue;
    tagValue = widget.initiaTagValue;
  }

  void _showDateTimePicker() async {
    final now = DateTime.now();
    final initialDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
        context: context, firstDate: initialDate, lastDate: now);

    if (pickedDate != null) {
      setState(() {
        _selectedDate = converter.format(pickedDate);
      });
    }
  }

  void _saveExpense() {
    final expense = Expense(
        amount: double.parse(_amountController.text),
        categoryId: categoryValue,
        payee: _payeeController.text,
        note: _noteController.text,
        date: converter.parse(_selectedDate),
        tag: tagValue);
    Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
  }

  @override
  void dispose() {
    _amountController.clear();
    _noteController.clear();
    _payeeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild ${widget.initiaCategoryValue}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Expense"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              buildTextFieldForm(
                  _amountController, 'Amount', TextInputType.number),
              buildTextFieldForm(_payeeController, 'Payee', TextInputType.text),
              buildTextFieldForm(_noteController, 'Notes', TextInputType.text),
              DropdownButtonFormField(
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Field required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Category'),
                  ),
                  items: widget.categories
                      .map((category) => DropdownMenuItem(
                            value: category.name,
                            child: Text(category.name),
                          ))
                      .toList(),
                  value: categoryValue,
                  onChanged: (value) {
                    setState(() {
                      categoryValue = value.toString();
                    });
                  }),
              DropdownButtonFormField(
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Field required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Tag')),
                  items: widget.tags
                      .map((tag) => DropdownMenuItem(
                            value: tag.name,
                            child: Text(tag.name),
                          ))
                      .toList(),
                  value: tagValue,
                  onChanged: (value) {
                    setState(() {
                      tagValue = value.toString();
                    });
                  }),
              ListTile(
                title: Text(_selectedDate),
                trailing: IconButton(
                    onPressed: _showDateTimePicker,
                    icon: Icon(Icons.calendar_month)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      _saveExpense();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Save Expense',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldForm(
      TextEditingController controller, String label, TextInputType typeInput) {
    return TextFormField(
      key: ValueKey(controller),
      controller: controller,
      keyboardType: typeInput,
      validator: (value) {
        if (value == null || value == '') {
          return 'Field required';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
