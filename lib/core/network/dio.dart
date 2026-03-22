

//
// curl -X GET "https://api.aladhan.com/v1/calendar/2026/2?latitude=30.17922&longitude=32.2056&method=5&shafaq=general&tune=0%2C0%2C0%2C0%2C0%2C0%2C0%2C0%2C0" \


import 'package:dio/dio.dart';

class dio_client{
final expensebaseUrl='https://699ac322377ac05ce28e9fdd.mockapi.io/expense';
final adhanUrl='https://api.aladhan.com/v1/calendar';
  late final Dio _dio=Dio(
    BaseOptions(baseUrl:
    adhanUrl ,
    headers: {'content-type':'application/json'},

    ),

  );

  // dio_client(){
  //
  //   _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
  //     // final token= cash.getFromCash(key: 'token');
  //
  //     if(token!=null && token .isNotEmpty && token!='geust'){
  //       options.headers['Authorization'] = 'Bearer $token';
  //     }
  //     return handler.next(options);
  //
  //   },));
  //
  // }
Dio get dio=>_dio;


}