import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleC = TextEditingController();
  final _amntC = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amntC.text.isEmpty) {
      return;
    }

    if (_titleC.text.isEmpty ||
        int.parse(_amntC.text) <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.addTx(_titleC.text, int.parse(_amntC.text), _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleC,
                onSubmitted: (_) => _submitData,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _amntC,
                onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount"),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Choosen !"
                            : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                        style: TextStyle(
                            letterSpacing: 1.5, color: Colors.grey[700]),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).accentColor,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: RaisedButton(
                  child: Text("Add Transaction"),
                  color: Theme.of(context).accentColor,
                  onPressed: _submitData,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
