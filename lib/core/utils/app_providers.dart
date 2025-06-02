import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/products/data/datasources/product_remote_data_source_impl.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: 'https://api-url.com'));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SupabaseClient>.value(
          value: Supabase.instance.client,
        ),

        RepositoryProvider<Dio>.value(value: dio),
        RepositoryProvider<AuthRepository>(
          create:
              (context) => AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(
                  supabase: context.read<SupabaseClient>(),
                ),
              ),
        ),
        RepositoryProvider<ProductRepository>(
          create:
              (context) => ProductRepositoryImpl(
                remoteDataSource: ProductRemoteDataSourceImpl(),
              ),
        ),
      ],
      child: child,
    );
  }
}
