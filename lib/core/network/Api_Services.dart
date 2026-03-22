import 'package:dio/dio.dart';

import 'apiError.dart';
import 'apiException.dart';
import 'dio.dart';

class apiService {
  dio_client _dioclient = dio_client();

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {

      final response = await _dioclient.dio.get(endpoint, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      apiException.handle(e);
      rethrow;
    } catch (e) {
      throw apiError(error: e.toString());
    }
  }


  Future<dynamic> post(endpont, body) async {
    try {
      final response = await _dioclient.dio.post(endpont, data: body);
      final data = response.data;
      return data;
    } on DioException catch (e) {
      apiException.handle(e);
      rethrow;
    }catch(e){
      throw apiError(error: e.toString());
    }
  }



  Future<dynamic> put(endpont, body) async {
    try {
      final response = await _dioclient.dio.put(endpont, data: body);
      final data = response.data; return data;

    } on DioException catch (e) {
      apiException.handle(e);rethrow;
    }
  }

  Future<dynamic> delete(endpont, body) async {
    try {
      final response = await _dioclient.dio.delete(endpont, data: body);
      final data = response.data; return data;
    } on DioException catch (e) {
      apiException.handle(e);rethrow;
    }
  }

}
