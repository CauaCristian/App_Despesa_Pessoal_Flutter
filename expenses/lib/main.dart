
import 'package:expenses/components/TransactionForm.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'models/transaction.dart';
import 'components/transactionList.dart';
import 'components/chart.dart';

void main() {
  runApp(AppExpenses());
}

class AppExpenses extends StatelessWidget {
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: "t1",value: 200.0,title: "conta #1",data: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: "t2",value: 250.0,title: "conta #2",data: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: "t3",value: 500.0,title: "conta #2",data: DateTime.now().subtract(Duration(days: 4))),
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  _addTransaction(String title, double value){
    final newTransaction = Transaction(
    id: Random().nextDouble().toString(),
    title: title,
    value: value,
    data: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _remove(int index){
    setState(() {
      // ignore: list_remove_unrelated_type
      _transactions.remove(index);
    });
  }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return TransactionForm(onSubmit: _addTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
        IconButton(
          onPressed: (){
            _openTransactionFormModal(context);
          }, 
          icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Chart(recentTransaction: _recentTransactions),
                  TransactionList(transactions: _transactions, remove: _remove,),
                ],
        ),
      ),
      floatingActionButton: 
        FloatingActionButton(
                              child: Icon(Icons.add), 
                              onPressed: (){
                                _openTransactionFormModal(context);
                              },
                              
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

