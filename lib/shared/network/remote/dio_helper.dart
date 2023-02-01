
import 'package:dio/dio.dart';
import 'package:store_app/models/product_model.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
  }) async {
    return await dio.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    Response? response;
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    return   response =await dio.post(
      url,
      data: data,
    );
    

  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    Response? response;
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    return   response =await dio.put(
      url,
      data: data,
    );


  }


}
