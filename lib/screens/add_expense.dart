import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_tracker_coursera/models/expense.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';
import 'package:expenses_tracker_coursera/utils.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _payeeController = TextEditingController();
  final _noteController = TextEditingController();
  final List<String> _categories = ['Teste1', 'Teste2'];
  final List<String> _tags = ['Teste1', 'Teste2'];

  String _selectedDate = converter.format(DateTime.now());
  String _category = 'Teste1';
  String _tag = 'Teste1';

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
        categoryId: _category,
        payee: _payeeController.text,
        note: _noteController.text,
        date: converter.parse(_selectedDate),
        tag: _tag);

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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Category'),
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _category = value.toString();
                      }
                    });
                  }),
              DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Tag')),
                  items: _tags
                      .map((tag) => DropdownMenuItem(
                            value: tag,
                            child: Text(tag),
                          ))
                      .toList(),
                  value: _tag,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _tag = value.toString();
                      }
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
                    _formKey.currentState!.validate();
                    _saveExpense();
                    Navigator.pop(context);
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
