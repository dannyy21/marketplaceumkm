import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl({required this.supabase});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null || response.user == null) {
      throw Exception('Login failed');
    }
    print(response.user!);
    return UserModel.fromSupabaseUser(response.user!);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Sign up
    final signUpResult = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (signUpResult.user == null) {
      throw Exception('Register failed');
    }

    // 2. Optional: Tambah metadata
    await supabase.auth.updateUser(UserAttributes(data: {'name': name}));

    // 3. Langsung login ulang
    final loginResult = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (loginResult.session == null || loginResult.user == null) {
      throw Exception('Login after register failed');
    }

    return UserModel.fromSupabaseUser(loginResult.user!);
  }
}
