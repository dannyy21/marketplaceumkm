import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return userModel.toEntity();
  }

  @override
  Future<User> register(String name, String email, String password) async {
    final userModel = await remoteDataSource.register(name, email, password);
    return userModel.toEntity();
  }
}
