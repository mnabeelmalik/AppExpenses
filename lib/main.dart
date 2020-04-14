import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        fontFamily: "DS-DIGIT",
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _Uset_tr = [
    // Transaction(
    //   id: 't1',
    //   title: 'new p',
    //   amount: 59.22,
    //   dttime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'new p2',
    //   amount: 30.22,
    //   dttime: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransaction {
    return _Uset_tr.where((tx) {
      return tx.dttime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _Deletetransaction(String id) {
    setState(() {
      _Uset_tr.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _Addnew(String txtit, double txamt, DateTime mydate) {
    final newtx = Transaction(
      title: txtit,
      amount: txamt,
      dttime: mydate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _Uset_tr.add(newtx);
    });
  }

  void _StartAddnewTrans(BuildContext ctx) // from down to up form page
  {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Newtrans(_Addnew),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Expense Cal"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _StartAddnewTrans(context),
          ),
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransaction),
            TransactionList(_Uset_tr,_Deletetransaction),
          ],
        ),
      ),
    );
  }
}
