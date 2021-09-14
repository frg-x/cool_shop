part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartProductError extends CartState {
  CartProductError(this.text);
  final String text;
}
