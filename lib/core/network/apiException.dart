import 'package:dio/dio.dart';

import 'apiError.dart';

 class apiException{

    static apiError handle(DioException error){

    if (error.type case DioExceptionType.connectionTimeout) {
      throw apiError(error: 'connectionTimeout');
    }

    else if (error.type case DioExceptionType.sendTimeout) {
      throw apiError(error: 'sendTimeout');
    }

    else if (error.type case DioExceptionType.receiveTimeout) {
      throw apiError(error: 'receiveTimeout');
    }

    else if (error.type case DioExceptionType.badCertificate) {
      throw apiError(error: 'badCertificate');
    }

    else if (error.type case DioExceptionType.badResponse) {
      throw apiError(error: 'badResponse');
    }

    else if (error.type case DioExceptionType.cancel) {
      throw apiError(error: 'cancel');
    }

    else if (error.type case DioExceptionType.connectionError) {
      throw apiError(error: 'connectionError');
    }

    else if (error.type case DioExceptionType.unknown) {
      throw apiError(error: 'unknown');

    }

    else{  throw apiError(error: 'anothre error');}
  }
}