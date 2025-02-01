import 'package:flutter/material.dart';

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
  String _category = '';

  String _notNullValitador(String? value) {
    if (value == null || value == '') {
      return 'This field is required';
    }
    return '';
  }

  final List<String> categories = ['Teste1', 'Teste2'];

  @override
  void dispose() {
    _amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Expense"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            spacing: 5,
            children: [
              TextFormField(
                controller: _amountController,
                validator: (value) => _notNullValitador(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                  prefixText: '\$ ',
                  label: Text("Amount"),
                ),
              ),
              TextFormField(
                controller: _payeeController,
                validator: (value) => _notNullValitador(value),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                  label: Text("Payee"),
                ),
              ),
              TextFormField(
                controller: _noteController,
                validator: (value) => _notNullValitador(value),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                  label: Text("Note"),
                ),
              ),
              DropdownButtonFormField(
                  items: categories
                      .map((e) => DropdownMenuItem(child: Text(e)))
                      .toList(),
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _category = value.toString();
                      }
                    });
                  }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _formKey.currentState!.validate(),
                  child: Text(
                    'Save Expense',
                    //style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
