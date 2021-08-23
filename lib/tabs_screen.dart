import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/widgets/my_bottom_navbar.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<TabSwitchingCubit, TabSwitchingState>(
      builder: (context, state) {
        //context.read<LoginCubit>().checkLoginState();
        activeScreenNumber = (state as TabsSwitch).activeScreenNumber;
        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          bottomNavigationBar:
              MyBottomNavigationBar(activeScreen: activeScreenNumber),
          body: screensList[activeScreenNumber],
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<LoginCubit>().signOut();
            },
          ),
        );
      },
    );
  }
}
