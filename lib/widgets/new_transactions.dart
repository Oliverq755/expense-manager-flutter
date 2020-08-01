import 'package:flutter/material.dart';

class NewTransation extends StatefulWidget {
  final Function addTx;

  NewTransation(this.addTx);

  @override
  _NewTransationState createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text("Add Transaction"),
              onPressed: () => submitData(),
              textColor: Colors.white,
              // splashColor: const Color(0xFF051937),
              color: const Color(0xFF0F0C29),
            )
          ],
        ),
      ),
    );
  }
}
