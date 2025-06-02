import 'package:dio/dio.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> fetchProductList() async {
    await Future.delayed(const Duration(seconds: 1)); // simulasi API

    return [
      ProductModel(
        id: '1',
        name: 'Produk A',
        imageUrl: 'https://via.placeholder.com/150',
        price: 10000,
      ),
      ProductModel(
        id: '2',
        name: 'Produk B',
        imageUrl: 'https://via.placeholder.com/150',
        price: 15000,
      ),
    ];
  }
}
