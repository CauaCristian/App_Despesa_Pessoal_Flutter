import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController = TextEditingController();

  final valueController = TextEditingController();

  final dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = tituloController.text;
    final value = double.parse(valueController.text);
    final data = _selectedDate;
    if (title.isEmpty || value < 0) {
      return;
    }
    widget.onSubmit(title, value, data);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: "Titulo",
              ),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Data selecionada: ${DateFormat("dd/MM/y").format(_selectedDate)}",
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text("Selecionar data"),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Nova transaçâo"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
