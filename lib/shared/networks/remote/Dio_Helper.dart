import 'package:news/layout/news_app/cubit/Cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(//423d36eb91c4402bb27997fd9932cafe
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}