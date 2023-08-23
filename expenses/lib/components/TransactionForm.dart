import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController  = TextEditingController();

  final valueController = TextEditingController();

  final dateController = TextEditingController();

  _submitForm(){
    final title = tituloController.text;
    final value = double.parse(valueController.text);
    if(title.isEmpty || value < 0){
      return;
    }
    widget.onSubmit(title,value);
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
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: "Valor (R\$)",
                          ),
                        ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
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