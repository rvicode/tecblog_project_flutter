import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioServices {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['Content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['Content-Type'] = 'application/json';
    return await dio
        .post(url,
            data: map,
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((value) {
      log(value.data.isString());
      log(value.headers.toString());
      log(value.statusCode.toString());
      return value;
    });
  }
}
