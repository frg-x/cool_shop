part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  FavoritesLoaded(this.favProductsList);
  final List<Product> favProductsList;
}

class FavoritesError extends FavoritesState {
  FavoritesError(this.error);
  final String error;
}
