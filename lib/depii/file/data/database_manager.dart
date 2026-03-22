import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'ExpenseModel.dart';

class DatabaseManager {
  static Future<List<ExpenseModel>> getExpense() async {
    final file = await _getFile();
    if (!file.existsSync()) {
      return [];
    }
    final jsonContent = await file.readAsString();
    if (jsonContent.isNotEmpty) {
      //convert from json string to list of map
      final jsonList = json.decode(jsonContent) as List;

      //convert from list of map to list of journal
      List<ExpenseModel> Expense = [];
      for (var jsonMap in jsonList) {
        Expense.add(ExpenseModel.fromJson(jsonMap));
      }
      //return list of journal
      return Expense;
    }
    return [];
  }

  static Future<void> addExpense(ExpenseModel ExpenseItem) async {
    //get current list of journal
    final Expenses = await getExpense();

    //add new journal
    Expenses.add(ExpenseItem);

    //convert list again to json
    final jsonList = json.encode(Expenses.map((e) => e.toJson()).toList());
    final file = await _getFile();

    //save json again to file
    await file.writeAsString(jsonList);
    return;
  }

  static Future<void> updateExpenses(ExpenseModel Expenses) async {
    return;
  }

  static Future<void> deleteExpenses(int id) async {
    return;
  }

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/Expenses.json');
  }
}
