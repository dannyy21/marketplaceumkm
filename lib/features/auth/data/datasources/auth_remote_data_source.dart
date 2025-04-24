// data/datasources/auth_remote_data_source.dart
import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      'https://your-api-url.com/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await dio.post(
      'https://your-api-url.com/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data['data']);
  }
}
