import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/usecases/get_product_list.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductList getProductList;

  ProductBloc({required this.getProductList}) : super(ProductInitial()) {
    on<GetProductListEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProductList();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
