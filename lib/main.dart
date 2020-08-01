import './widgets/chart.dart';

import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expensegator',
      theme: ThemeData(
        fontFamily: 'OpenSans',
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
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 'T1', title: 'New Shoes', amount: 453.99, date: DateTime.now()),
    // Transaction(
    //     id: 'T1', title: 'New Shirt', amount: 657.99, date: DateTime.now()),
    // Transaction(id: 'T1', title: 'Rent', amount: 589.99, date: DateTime.now()),
    // Transaction(
    //     id: 'T1',
    //     title: 'Daily Groceries',
    //     amount: 643.99,
    //     date: DateTime.now()),
    // Transaction(
    //     id: 'T1', title: 'New Pants', amount: 654.99, date: DateTime.now()),
    // Transaction(
    //     id: 'T1', title: 'Bike repair', amount: 88.99, date: DateTime.now()),
    // Transaction(
    //     id: 'T1', title: 'Lunch box', amount: 345.99, date: DateTime.now())
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransation(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expensegator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                const Color(0xFF0F0C29),
                const Color(0xFF24243E)
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[const Color(0xFF0F0C29), const Color(0xFF24243E)],
            ),
          ),
          child: Column(
            // mainAxisAlignment: ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: const Color(0xFFED213A),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
