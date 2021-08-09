import 'package:cool_shop/home_screen/model/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AllColors {
  static const primary = Color(0xFFDB3022);
  static const appBackgroundColor = Color(0xFFF9F9F9);

  static const dark = Color(0xFF222222);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const bigButtonShadow = Color(0xFFD32626);
  static const error = Color(0xFFF01F0E);
  static const success = Color(0xFF2AA952);

  static const bigTextFieldLabelColor = Color(0xFF9B9B9B);
  static const bigTextFieldTextColor = Color(0xFF2D2D2D);

  static const gray = Color(0xFF9B9B9B);
}

class AllStyles {
  static const headlineActive = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AllColors.dark,
  );

  static const headlineNotActive = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  static const bigButton = TextStyle(
    color: AllColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const bigTextFieldError = TextStyle(
    color: AllColors.error,
    fontSize: 11,
    height: 0.5,
  );

  static const bigTextFieldLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: AllStrings.fontFamily,
    color: AllColors.bigTextFieldLabelColor,
  );
  static const dark14w400 = TextStyle(
    color: AllColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const gray14w400 = TextStyle(
    color: AllColors.gray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const primary14w400 = TextStyle(
    color: AllColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const dark16w500 = TextStyle(
    color: AllColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const discountLabel = TextStyle(
    color: AllColors.white,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static const gray11 = TextStyle(
    color: AllColors.gray,
    fontSize: 11,
  );

  static const primary11 = TextStyle(
    color: AllColors.primary,
    fontSize: 11,
  );

  static const gray10 = TextStyle(
    color: AllColors.gray,
    fontSize: 10,
  );
}

class AllStrings {
  static const fontFamily = 'Metropolis';
}

enum TextFieldType {
  name,
  email,
  password,
}

enum PageTypes {
  signUp,
  login,
  forgotPassword,
}

List<ProductCard> mainScreenProducts = [
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/2469699748_w640_h640_zhenskoe-letnee-plate.jpg',
    vendor: 'Gucci',
    title: 'Evening Dress',
    price: 20,
    priceDiscounted: 16,
    rating: 4,
    reviewsNumber: 8,
  ),
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/3201861516_w640_h640_zhenskoe-letnee-plate.jpg',
    vendor: 'D&G',
    title: 'Sport Dress',
    price: 25,
    priceDiscounted: 19,
    rating: 2,
    reviewsNumber: 16,
  ),
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/3203616109_w700_h500_platya-i-sarafany.jpg',
    vendor: 'Armani',
    title: 'Sport Dress',
    price: 27,
    priceDiscounted: 22,
    rating: 5,
    reviewsNumber: 10,
  ),
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/3262141439_w640_h640_plate-rubashka-zhenskoe-stilnoe.jpg',
    vendor: 'Gucci',
    title: 'Women\'s Stylish Shirt Dress',
    price: 42,
    priceDiscounted: 30,
    rating: 4,
    reviewsNumber: 8,
  ),
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/2259092247_w640_h640_plate-krasivoe-shelkovoe.jpg',
    vendor: 'Bvlgari',
    title: 'Beautiful Silk Wrap Dress',
    price: 35,
    priceDiscounted: 24,
    rating: 5,
    reviewsNumber: 5,
  ),
  ProductCard(
    imageURL:
        'https://images.ua.prom.st/1175944793_w640_h640_sarafan-yubka.jpg',
    vendor: 'H&M',
    title: 'Fashion Sundress',
    price: 19,
    priceDiscounted: 17,
    rating: 4,
    reviewsNumber: 22,
  ),
];
