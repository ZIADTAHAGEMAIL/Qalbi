

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamicapp/depii/file/data/ExpenseModel.dart';

class Httpexpense {
  final baseUrl='https://699ac322377ac05ce28e9fdd.mockapi.io/expense';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<ExpenseModel>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => ExpenseModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل تحميل البيانات');
    }
  }

  Future<bool> add(String endpoint, ExpenseModel expense) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(expense.toJson()),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<bool> update(String endpoint, ExpenseModel expense) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint/${expense.id}'),
      headers: _headers,
      body: jsonEncode(expense.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> delete(String endpoint, String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint/$id'),
      headers: _headers,
    );
    return response.statusCode == 200;
  }
}