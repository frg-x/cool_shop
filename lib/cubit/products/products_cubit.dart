import 'package:cool_shop/data/shop_repository.dart';
import 'package:cool_shop/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ShopRepository _shopRepository = ShopRepository();

  ProductsCubit() : super(const ProductsInitial());

  void getProducts() async {
    try {
      emit(const ProductsLoading());
      List<Product>? productsList = await _shopRepository.getProducts();
      if (productsList != null) {
        emit(ProductsLoaded(productsList));
      }
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
