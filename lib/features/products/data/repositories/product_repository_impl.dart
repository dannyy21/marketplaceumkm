import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProductList() async {
    final models = await remoteDataSource.fetchProductList();
    return models;
  }
}
