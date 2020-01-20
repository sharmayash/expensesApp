import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
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
                        child:
                            Text('Rs.${transaction[index].amount.toString()}'),
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
                  subtitle:
                      Text(DateFormat.yMMMd().format(transaction[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          label: Text("DELETE"),
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () => deleteTx(transaction[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => deleteTx(transaction[index].id),
                        ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
