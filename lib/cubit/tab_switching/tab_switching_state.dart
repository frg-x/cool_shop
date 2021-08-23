part of 'tab_switching_cubit.dart';

@immutable
abstract class TabSwitchingState {}

class TabsInitial extends TabSwitchingState {
  //final int activeScreenNumber;
  TabsInitial();
}

class TabsSwitch extends TabSwitchingState {
  final int activeScreenNumber;
  TabsSwitch(this.activeScreenNumber);
}
