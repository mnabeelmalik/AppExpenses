import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final  DateTime dttime;
  Transaction({@required this.id,@required this.title, @required this.amount,@required this.dttime});
}
