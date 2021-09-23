import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_size.dart';
import 'package:cool_shop/data/shop_repository.dart';
import 'package:cool_shop/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ShopRepository _shopRepository = ShopRepository();

  List<FilterSize> filterSizes = [];

  ProductsCubit() : super(const ProductsInitial()) {
    getProducts();
  }

  // List<Product> get getProductsList {
  //     List<Product> productsList = [];
  //   if (state is ProductsLoaded){
  //     productsList = state.products;
  //   }
  //     return productsList;
  // }

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

  //List<FilterSize> getProductSizes(int productId) =>

}
