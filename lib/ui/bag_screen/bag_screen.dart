import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/modal_sheet_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/bag_screen_cart_item.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({
    Key? key,
  }) : super(key: key);
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  bool isPromoEmpty = true;
  final _promoController = TextEditingController();

  void validator() {
    final text = _promoController.text;
    setState(() {
      if (text == '') {
        isPromoEmpty = true;
      } else {
        isPromoEmpty = false;
      }
    });
  }

  void clearPromo() {
    _promoController.clear();
    validator();
  }

  List<CartItem> cartItems = [];
  double totalSum = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartData) {
          cartItems = state.items;
          totalSum = state.sum;
        }
        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          appBar: AppBar(
            backgroundColor: AllColors.appBackgroundColor,
            elevation: 0,
            shadowColor: AllColors.black.withOpacity(0.25),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            iconTheme: const IconThemeData(color: AllColors.dark),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.search,
                  color: AllColors.dark,
                  size: 26,
                ),
              ),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Bag',
                    style: AllStyles.headlineActive,
                  ),
                  const SizedBox(height: 10),
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 14),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: cartItems
                        .map(
                            (cartItem) => BagScreenCartItem(cartItem: cartItem))
                        .toList(),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 25,
                          color: AllColors.black.withOpacity(0.08),
                        ),
                      ],
                      color: AllColors.white,
                      borderRadius: isPromoEmpty
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            )
                          : BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextField(
                            controller: _promoController,
                            onChanged: (_) => validator(),
                            maxLength: 30,
                            cursorColor: AllColors.dark,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              fillColor: AllColors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              counterText: '',
                              hintText: 'Enter your promo code',
                              hintStyle: AllStyles.gray14w400,
                            ),
                            style: AllStyles.dark14w500,
                          ),
                        ),
                        isPromoEmpty
                            ? SvgPicture.asset(
                                'assets/icons/enter_promo_arrow.svg')
                            : GestureDetector(
                                onTap: () => clearPromo(),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                      'assets/icons/clear_promo.svg'),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total amount:',
                        style: AllStyles.gray14w400,
                      ),
                      Text(
                        '${totalSum.toStringAsFixed(0)}\$',
                        style: AllStyles.dark18w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BigButton(
                    child: const Text(
                      'CHECK OUT',
                      style: AllStyles.bigButton,
                    ),
                    onPress: () {},
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void sortingTypeSheet(BuildContext context, Function onPress) {
  showModalBottomSheet(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: AllColors.appBackgroundColor,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          height: 352,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ModalSheetDivider(),
              SizedBox(height: 16),
              Text(
                'Sort by',
                style: AllStyles.dark18w600,
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      });
}
