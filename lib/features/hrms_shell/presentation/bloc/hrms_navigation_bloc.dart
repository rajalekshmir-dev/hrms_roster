import 'package:flutter_bloc/flutter_bloc.dart';
import 'hrms_navigation_event.dart';
import 'hrms_navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<ChangePageEvent>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
