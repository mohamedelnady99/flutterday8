import 'package:dio/dio.dart';

class UserWebServices {
  late Dio dio;

  UserWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> fetchUsers() async {
    Response response = await dio.get('users?page=2');

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }
}
