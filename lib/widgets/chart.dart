import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final Weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalsum = 0;
      for (int i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].dttime.day == Weekday.day &&
            recentTrans[i].dttime.month == Weekday.month &&
            recentTrans[i].dttime.year == Weekday.year) {
          totalsum += recentTrans[i].amount;
        }
      }
    //  print(DateFormat.E().format(Weekday));
      //print(totalsum);
      return {
        "day": DateFormat.E().format(Weekday).substring(0, 3),
        "amount": totalsum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((my_widget) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chartbar(
                my_widget["day"],
                my_widget["amount"],
                totalSpending == 0.0
                    ? 0.0 
                    : (my_widget["amount"] as double) / totalSpending,
              ),
            );
            // Text("${my_widget["day"]}: ${my_widget["amount"]}");
          }).toList(),
          //<Widget>[
        ),
      ),
    );
  }
}
