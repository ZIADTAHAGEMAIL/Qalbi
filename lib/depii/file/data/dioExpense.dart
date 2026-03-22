import 'dart:convert';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:islamicapp/core/network/Api_Services.dart';
import 'package:islamicapp/depii/file/data/ExpenseModel.dart';

import '../../../core/network/dio.dart';

class expenseRepo {
  apiService _apiservice = apiService();

  Future<void> add(ExpenseModel expense) async {
    final expenseMap = expense.toJson();
    // final expenseJson = json.encode(expenseMap);
    final response = await _apiservice.post('/expenses', expenseMap);
  }

  Future<List<ExpenseModel>> get() async {
    final response = await _apiservice.get('/expenses') as List;

    // final expenseMap = response.toJson();
    // final expense = json.decode(expenseMap) as List;
    return response.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  Future<void> update(ExpenseModel expense) async {
    final response = await _apiservice.put(
      '/expenses/${expense.id}',
      expense.toJson(),
    );
  }

  Future<void> delete(ExpenseModel expense) async {
    final response = await _apiservice.delete('/expenses/${expense.id}', null);
  }
}
