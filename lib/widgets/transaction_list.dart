import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transaction.isEmpty
            ? Center(
                child: Text(
                  "Add Your Transactions !",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                                'Rs.${transaction[index].amount.toString()}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transaction[index].title,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                            letterSpacing: 1.5,
                            color: Colors.teal),
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transaction[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deleteTx(transaction[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transaction.length,
              ));
  }
}
