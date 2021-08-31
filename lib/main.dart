// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// ignore: unused_import
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'verify_auth_status_screen.dart';

GetIt getIt = GetIt.instance;

void main() {
  registerDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const CoolShop());
  });
}

void registerDependencies() {
  //getIt.registerFactory<LoginCubit>(() => LoginCubit({}));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit({}));
}

class CoolShop extends StatelessWidget {
  const CoolShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TabSwitchingCubit()),
        //BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider.value(value: getIt<LoginCubit>()),
        BlocProvider(create: (context) => ProductsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cool Shop',
        theme: ThemeData(
          fontFamily: AllStrings.fontFamily,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AllColors.primary,
              ),
        ),
        home: VerifyAuthStatusScreen(),
      ),
    );
  }
}
