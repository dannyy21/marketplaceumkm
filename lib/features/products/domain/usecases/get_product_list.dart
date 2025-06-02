import 'package:injectable/injectable.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductList {
  final ProductRepository repository;

  GetProductList(this.repository);

  Future<List<Product>> call() => repository.getProductList();
}
