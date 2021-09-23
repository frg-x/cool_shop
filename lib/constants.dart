import 'package:cool_shop/ui/bag_screen/bag_screen.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_brand.dart';
import 'package:cool_shop/ui/categories_screen/widgets/sub_category_banner.dart';
import 'package:cool_shop/models/category.dart';
import 'package:cool_shop/models/sub_category.dart';
import 'package:cool_shop/models/sub_category_2.dart';
import 'package:cool_shop/ui/favorites_screen/favorites_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cool_shop/ui/categories_screen/category_screen.dart';
import 'ui/home_screen/home_screen.dart';
import 'package:cool_shop/ui/profile_screen/profile_screen.dart';

class GlobalUrls {
  static const String baseUrl =
      'https://9e55-188-163-49-239.ngrok.io'; //'https://1b478a7e5554.ngrok.io';
  static const String loginEndpoint = '/api/Person/Login';
  static const String refreshTokenEndpoint = '/api/Person/RefreshToken';
  static const String createUserEndpoint = '/api/Person/CreateUser';
  static const String verifyNewUser = '/api/Person/Verify';
  static const String sendEmailToResetPassword =
      '/api/Person/SendEmailToRecoverPassword';
  static const String resetPassword = '/api/Person/ResetPassword';
  static const String getAllProducts = '/api/Product/GetAll';
  static const String getFavoriteProducts = '/api/FavoritProduct/GetProducts';
  static const String addToFavoriteProducts = '/api/FavoritProduct/Create';

  static const String getPersonById = '/api/Person/GetPersonById';
  static const String getProfile = '/api/Person/GetProfile';

  //static const String sendEmailToRecoverEndpoint = '/api/Person/SendEmailToRecoverPassword';
}

class Constants {
  static const requestTimeoutSeconds = 3;
  static final categoryNavigatorKey = GlobalKey<NavigatorState>();
  static final globalNavigatorKey = GlobalKey<NavigatorState>();
  //static final filterNavigatorKey = GlobalKey<NavigatorState>();
}

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

  static const modalSheetLine = Color(0xFF9B9B9B);

  static const sizeOptionRedBorder = Color(0xFFF01F0E);
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
  static const dark14w500 = TextStyle(
    color: AllColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const dark14w600 = TextStyle(
    color: AllColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const gray14w500 = TextStyle(
    color: AllColors.gray,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const productDescriprtion = TextStyle(
    color: AllColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.15,
  );

  static const dark11w400 = TextStyle(
    color: AllColors.dark,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  static const dark15w700 = TextStyle(
    color: AllColors.dark,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const gray14w400 = TextStyle(
    color: AllColors.gray,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const white14w500 = TextStyle(
    color: AllColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const white16w600 = TextStyle(
    color: AllColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const white14w400 = TextStyle(
    color: AllColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const primary14w400 = TextStyle(
    color: AllColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const white24w600 = TextStyle(
    color: AllColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const dark16w500 = TextStyle(
    color: AllColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const dark16w600 = TextStyle(
    color: AllColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const dark16w400 = TextStyle(
    color: AllColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const primary16w600 = TextStyle(
    color: AllColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const discountLabel = TextStyle(
    color: AllColors.white,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  static const dark18w600 = TextStyle(
    color: AllColors.dark,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const dark24w600 = TextStyle(
    color: AllColors.dark,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const gray11 = TextStyle(
    color: AllColors.gray,
    fontSize: 11,
  );

  static const gray14 = TextStyle(
    color: AllColors.gray,
    fontSize: 14,
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
  code,
}

enum PageTypes {
  signIn,
  signUp,
}

// List<Product> mainScreenProducts = [
//   Product(
//     id: 1,
//     imageUrl:
//         'https://images.ua.prom.st/2469699748_w640_h640_zhenskoe-letnee-plate.jpg',
//     collection: 'Gucci',
//     title: 'Evening Dress',
//     price: 20,
//     discount: 0.19,
//     rating: 4,
//     ratingCount: 8,
//   ),
//   Product(
//     id: 2,
//     imageUrl:
//         'https://images.ua.prom.st/3201861516_w640_h640_zhenskoe-letnee-plate.jpg',
//     collection: 'D&G',
//     title: 'Sport Dress',
//     price: 25,
//     discount: 0.24,
//     rating: 2,
//     ratingCount: 16,
//   ),
//   Product(
//     id: 3,
//     imageUrl:
//         'https://images.ua.prom.st/3203616109_w700_h500_platya-i-sarafany.jpg',
//     collection: 'Armani',
//     title: 'Sport Dress',
//     price: 27,
//     discount: 0.18,
//     rating: 5,
//     ratingCount: 10,
//   ),
//   Product(
//     id: 4,
//     imageUrl:
//         'https://images.ua.prom.st/3262141439_w640_h640_plate-rubashka-zhenskoe-stilnoe.jpg',
//     collection: 'Gucci',
//     title: 'Women\'s Stylish Shirt Dress',
//     price: 42,
//     discount: 0.25,
//     rating: 4,
//     ratingCount: 8,
//   ),
//   Product(
//     id: 5,
//     imageUrl:
//         'https://images.ua.prom.st/2259092247_w640_h640_plate-krasivoe-shelkovoe.jpg',
//     collection: 'Bvlgari',
//     title: 'Beautiful Silk Wrap Dress',
//     price: 35,
//     discount: 0.31,
//     rating: 5,
//     ratingCount: 5,
//   ),
//   Product(
//     id: 6,
//     imageUrl:
//         'https://images.ua.prom.st/1175944793_w640_h640_sarafan-yubka.jpg',
//     collection: 'H&M',
//     title: 'Fashion Sundress',
//     price: 19,
//     discount: 0.10,
//     rating: 4,
//     ratingCount: 22,
//   ),
// ];

List<Category> categories = [
  Category(
    id: 0,
    title: 'Women',
    subCategories: [
      const SubCategoryBanner(id: 7),
      SubCategory(
          id: 0,
          title: 'New',
          image: 'assets/images/women/new.png',
          subSubCategories: []),
      SubCategory(
        id: 1,
        title: 'Clothes',
        image: 'assets/images/women/clothes.png',
        subSubCategories: [
          SubCategory2(id: 0, title: 'Tops', internalTitle: 'Women\'s tops'),
          SubCategory2(
              id: 1, title: 'Shirts & Blouses', internalTitle: 'Women\'s tops'),
          SubCategory2(
              id: 2,
              title: 'Cardigans & Sweaters',
              internalTitle: 'Women\'s tops'),
          SubCategory2(
              id: 3, title: 'Knitwear', internalTitle: 'Women\'s tops'),
          SubCategory2(id: 4, title: 'Blazers', internalTitle: 'Women\'s tops'),
          SubCategory2(
              id: 5, title: 'Outerwear', internalTitle: 'Women\'s tops'),
          SubCategory2(id: 6, title: 'Pants', internalTitle: 'Women\'s tops'),
          SubCategory2(id: 7, title: 'Jeans', internalTitle: 'Women\'s tops'),
          SubCategory2(id: 8, title: 'Shorts', internalTitle: 'Women\'s tops'),
          SubCategory2(id: 9, title: 'Skirts', internalTitle: 'Women\'s tops'),
          SubCategory2(
              id: 10, title: 'Dresses', internalTitle: 'Women\'s tops'),
        ],
      ),
      SubCategory(
          id: 2,
          title: 'Shoes',
          image: 'assets/images/women/shoes.png',
          subSubCategories: []),
      SubCategory(
          id: 3,
          title: 'Accesories',
          image: 'assets/images/women/accesories.png',
          subSubCategories: []),
    ],
  ),
  Category(
    id: 1,
    title: 'Men',
    subCategories: [
      SubCategory(
          id: 0,
          title: 'New',
          image: 'assets/images/women/new.png',
          subSubCategories: []),
      SubCategory(
          id: 1,
          title: 'Clothes',
          image: 'assets/images/women/clothes.png',
          subSubCategories: []),
    ],
  ),
  Category(
    id: 2,
    title: 'Kids',
    subCategories: [
      SubCategory(
          id: 2,
          title: 'Shoes',
          image: 'assets/images/women/shoes.png',
          subSubCategories: []),
      SubCategory(
          id: 3,
          title: 'Accesories',
          image: 'assets/images/women/accesories.png',
          subSubCategories: []),
    ],
  ),
];

List<Widget> get screensList => [
      const HomeScreen(),
      const CategoriesScreen(),
      const BagScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

List<FilterBrand> copyList(List<FilterBrand> list) {
  List<FilterBrand> newList = [];
  for (FilterBrand brand in list) {
    newList.add(brand.copyWith());
  }
  return newList;
}
