import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dioBusiness;

  static init() {
    dioBusiness = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> query,
  }) async {
    return await dioBusiness.get(path, queryParameters: query);
  }
}
