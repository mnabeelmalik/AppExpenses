import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Newtrans extends StatefulWidget {
  final Function addTx;

  Newtrans(this.addTx);

  @override
  _NewtransState createState() => _NewtransState();
}

class _NewtransState extends State<Newtrans> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();

  DateTime _selectedDate;
  void _Submit_data() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);
    // final entereddate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    } else {
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
    }
    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((picked_Date) {
      if (picked_Date == null) {
        return;
      } else {
        setState(() {
          _selectedDate = picked_Date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titlecontroller,
              onSubmitted: (_) => _Submit_data(),
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
                controller: _amountcontroller,
                onSubmitted: (_) => _Submit_data(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount")),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Choosen"
                        : "Picked Date is: " +
                            DateFormat("dd-MM-yyyy").format(_selectedDate)),
                  ),
                  Container(
                    child: RaisedButton(
                      child: Text(
                        "Choose Date",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.white,
                      //Theme.of(context).primaryColor,
                      color: Colors.redAccent[200],
                      onPressed: _presentDate,
                      elevation: 3,
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                "ADD",
                textScaleFactor: 1.9,
              ),
              elevation: 3,
              color: Colors.black,
              textColor: Colors.white,

              //textColor: Theme.of(context).textTheme.button.color,
              onPressed: _Submit_data,
            )
          ],
        ),
      ),
    );
  }
}
