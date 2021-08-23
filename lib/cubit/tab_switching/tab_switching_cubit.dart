import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_switching_state.dart';

class TabSwitchingCubit extends Cubit<TabSwitchingState> {
  TabSwitchingCubit() : super(TabsInitial()) {
    setInitialTabNumber();
  }

  int initialTabNumber = 0;
  late int activeScreenNumber;

  void setActiveTabNumber(int num) {
    activeScreenNumber = num;
    emit(TabsSwitch(activeScreenNumber));
  }

  int get getActiveTabNumber => activeScreenNumber;

  void setInitialTabNumber() {
    emit(TabsSwitch(initialTabNumber));
  }
}
