import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/products/data/datasources/product_remote_data_source_impl.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_product_list.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;

void setupInjection() {
  // External
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data Source
  getIt.registerLazySingleton<ProductRemoteDataSourceImpl>(
    () => ProductRemoteDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt<ProductRemoteDataSourceImpl>(),
    ),
  );

  // Use Case
  getIt.registerLazySingleton<GetProductList>(
    () => GetProductList(getIt<ProductRepository>()),
  );

  // Bloc
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getProductList: getIt<GetProductList>()),
  );
}
