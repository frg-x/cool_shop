import 'package:bloc/bloc.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItem> _items = [];
  double sum = 0;

  List<CartItem> get getItems => _items;

  void addItem(CartItem cartItem) {
    if (cartItem.color == '' && cartItem.size == 'Size') {
      emit(CartProductError('Please select product options'));
      return;
    }

    if (cartItem.color == '') {
      emit(CartProductError('Please select product color'));
      return;
    }

    if (cartItem.size == 'Size') {
      emit(CartProductError('Please select product size'));
      return;
    }

    CartItem? foundCartElement;

    if (_items.isNotEmpty) {
      try {
        foundCartElement = _items.firstWhere(((element) =>
            (element.id == cartItem.id &&
                element.color == cartItem.color &&
                element.size == cartItem.size)));
        foundCartElement.quantity += 1;
        //print('plus quantity');
      } on StateError {
        _items.add(cartItem);
        //print('add1');
      }
    } else {
      _items.add(cartItem);
      //print('add2');
    }
    calculate();
  }

  void deleteItem(int productId) {}

  void calculate() {
    sum = 0;
    for (var element in _items) {
      sum += element.price * element.quantity;
    }
    _printOutCartContent();
  }

  double get getTotalSum => sum;

  void incrementCartItem(CartItem cartItem) {
    CartItem foundCartElement = _items.firstWhere(((element) =>
        (element.id == cartItem.id &&
            element.color == cartItem.color &&
            element.size == cartItem.size)));
    foundCartElement.quantity += 1;
    calculate();
  }

  void decrementCartItem(CartItem cartItem) {
    CartItem foundCartElement = _items.firstWhere(((element) =>
        (element.id == cartItem.id &&
            element.color == cartItem.color &&
            element.size == cartItem.size)));
    if (foundCartElement.quantity > 1) {
      foundCartElement.quantity -= 1;
    } else {
      final elementIndexToDelete = _items.indexWhere((element) =>
          (element.id == cartItem.id &&
              element.color == cartItem.color &&
              element.size == cartItem.size));
      _items.removeAt(elementIndexToDelete);
    }
    calculate();
  }

  void _printOutCartContent() {
    for (var element in _items) {
      print(
          '${element.id}, ${element.title}, ${element.price}*${element.quantity}=${element.price * element.quantity}, ${element.color}, ${element.size}');
      print(getTotalSum);
    }
  }
}
