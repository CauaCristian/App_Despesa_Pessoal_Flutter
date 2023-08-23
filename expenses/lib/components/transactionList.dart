import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(int index) remove;

  TransactionList({required this.transactions, required this.remove});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 650,
      child: transactions.isEmpty ?  SingleChildScrollView(
        child: Column(
          children: [
          const SizedBox(height: 50,),
            Text(
              "Nenhuma Transação Cadastrada !!!",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20,),
            Container(
              height: 400,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
            ),
          ],
        ),
      ) : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx,index){
        final tr = transactions[index];
        return Card(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).colorScheme.primary,
                                  ), 
                                  borderRadius: const BorderRadius.all(Radius.circular(400))
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                              "R\$ ${tr.value.toStringAsFixed(2)}",
                                              style: Theme.of(context).textTheme.headline6,
                                        ),
                              ),
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(
                                    tr.title,
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    DateFormat("d MMM y").format(tr.data),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              IconButton(onPressed: () => remove(index),
                              icon: const Icon(Icons.delete,))
                            ],
                          ),
                        );
      },
      ),
    );
  }
}