import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:project111/components/storage_const.dart';

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
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['Content-Type'] = 'application/json';
    var token = GetStorage().read(StorageKey.token);
    if (token != null) {
      dio.options.headers['authorization'] = '$token';
    }
    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((value) {
      return value;
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }
}
