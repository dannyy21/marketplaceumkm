import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'package:dio/dio.dart';

void main() {
  final dio = Dio();

  final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dio);
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
  );

  final authBloc = AuthBloc(
    loginUseCase: Login(authRepository),
    registerUseCase: Register(authRepository),
  );

  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc? authBloc;

  const MyApp({this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>.value(value: authBloc!)],
      child: MaterialApp(
        title: 'UMKM Marketplace',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LoginPage(),
      ),
    );
  }
}
