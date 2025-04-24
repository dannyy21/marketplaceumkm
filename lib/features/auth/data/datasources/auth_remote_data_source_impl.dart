import 'package:dio/dio.dart';

import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        'https://your-api.com/login',
        data: {'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data['data']); // contoh struktur
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await dio.post(
        'https://your-api.com/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Registrasi gagal: $e');
    }
  }
}
