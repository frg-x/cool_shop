import 'package:bloc/bloc.dart';
import 'package:cool_shop/data/shop_repository.dart';
import 'package:cool_shop/models/product.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final ShopRepository _shopRepository = ShopRepository();

  List<Product> _favProductsList = [];

  FavoritesCubit() : super(FavoritesInitial()) {
    getFavoriteProducts();
  }

  List<Product> get getFavProductsList => _favProductsList;

  Future<void> addToFavorites(String productId, bool oldValue) async {
    try {
      emit(FavoritesLoading());

      await _shopRepository.addToFavorites(productId, oldValue);
      _favProductsList
          .firstWhere((element) => element.id == int.parse(productId));
      // if (favProductsList != null) {
      //   _favProductsList = favProductsList;
      //   emit(FavoritesLoaded(favProductsList));
      // }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(int productId) {
    if (_favProductsList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void getFavoriteProducts() async {
    try {
      emit(FavoritesLoading());
      List<Product>? favProductsList =
          await _shopRepository.getFavoriteProducts();
      if (favProductsList != null) {
        _favProductsList = favProductsList;
        emit(FavoritesLoaded(favProductsList));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
