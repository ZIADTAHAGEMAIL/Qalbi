import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp/depii/file/view/addView.dart';

import '../data/ExpenseModel.dart';
import '../data/dioExpense.dart';
import '../data/httpExpense.dart';

class Expenseview extends StatefulWidget {
  const Expenseview({super.key});

  @override
  State<Expenseview> createState() => _ExpenseviewState();
}

class _ExpenseviewState extends State<Expenseview> {
  List<ExpenseModel> expenses = [];
  Httpexpense httpExpense = Httpexpense();

  @override
  void initState() {

    super.initState();
    getexpenses();
  }

  Future<void> getexpenses() async {
    final expensesList = await httpExpense.get('/expenses');
    setState(() {
      expenses = expensesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker '), centerTitle: true),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final item = expenses[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,

              child: ListTile(
                onTap: () async {
                  final updatedItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Addview(
                        expense:

                            item,
                      ),
                    ),
                  );
                  getexpenses();
                },
                style: ListTileStyle.list,
                contentPadding: EdgeInsetsGeometry.all(12),
                title: Row(
                  children: [
                    Text('${item.Price}\$'),
                    Spacer(),
                    Text(item.date.split(' ')[0]),

                  ],
                ),
                subtitle: Text(item.Description),
                trailing: IconButton(
                  onPressed: () async {

                    await httpExpense.delete('/expenses', item.id!);
                    getexpenses();
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addview()),
          );

          getexpenses();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
