import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _User_tr;
  final Function Delete_trans;
  TransactionList(this._User_tr, this.Delete_trans);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _User_tr.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Data Found",
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text("\$${_User_tr[index].amount}",style: TextStyle(color: Colors.white,fontSize: 20),))),
                    ),
                    title: Text(_User_tr[index].title,
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(
                      DateFormat("dd-MM-yyyy").format(_User_tr[index].dttime),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete_sweep),
                        color: Colors.red,
                        onPressed: () => Delete_trans(_User_tr[index].id)),
                  ),
                );
              }, //ListView(

              itemCount: _User_tr.length,
              // children: _User_tr.map((tx) {}).toList(),
            ),
    );
  }
}
/*
 return Card(
                    elevation: 0.5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.redAccent,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            "\$ ${_User_tr[index].amount.toStringAsFixed(2)}", // + tx.amount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _User_tr[index].title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy")
                                  .format(_User_tr[index].dttime),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ));
                    */
