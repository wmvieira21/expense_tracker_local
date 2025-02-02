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
  final ScrollController _scrollController = ScrollController();

  String _category = 'Teste1';
  String _tag = 'Teste1';
  final List<String> _categories = ['Teste1', 'Teste2'];
  final List<String> _tags = ['Teste1', 'Teste2'];

  @override
  void dispose() {
    _amountController.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Expense"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
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
                      border: OutlineInputBorder(), label: Text('Category')),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _formKey.currentState!.validate();
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
