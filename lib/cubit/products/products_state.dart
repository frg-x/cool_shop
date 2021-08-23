part of 'products_cubit.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError(this.message);
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  const ProductsLoaded(this.products);
}
