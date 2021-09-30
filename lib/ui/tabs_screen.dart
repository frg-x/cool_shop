import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/cubit/favorites/favorites_cubit.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int activeScreenNumber = 0;

  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    context.read<FavoritesCubit>().getFavoriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabSwitchingCubit, TabSwitchingState>(
      builder: (context, state) {
        activeScreenNumber = (state as TabsSwitch).activeScreenNumber;
        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          bottomNavigationBar:
              MyBottomNavigationBar(activeScreen: activeScreenNumber),
          body: screensList[activeScreenNumber],
          floatingActionButton: const CustomFAB(),
        );
      },
    );
  }
}

class CustomFAB extends StatefulWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: AllColors.dark.withOpacity(0.8),
            //offset: Offset(10, 10),
            blurRadius: 20,
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Service actions:',
            style: AllStyles.dark15w700
                .copyWith(decoration: TextDecoration.underline),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () => context.read<LoginCubit>().signOut(),
          ),
          // const SizedBox(height: 10),
          // ElevatedButton(
          //   child: const Text('Read All keys'),
          //   onPressed: () => context.read<LoginCubit>().readAllSettings(),
          // ),
          // SizedBox(height: 10),
          // ElevatedButton(
          //   child: Text('Clear accessToken'),
          //   onPressed: () => context.read<LoginCubit>().clearAccessToken(),
          // ),
          // SizedBox(height: 10),
          // ElevatedButton(
          //   child: Text('Clear refreshToken'),
          //   onPressed: () => context.read<LoginCubit>().clearRefreshToken(),
          // ),
          // const SizedBox(height: 10),
          // ElevatedButton(
          //   child: const Text('Get Request'),
          //   onPressed: () => context.read<LoginCubit>().testGetRequest(),
          // ),
        ],
      ),
    );
  }
}
