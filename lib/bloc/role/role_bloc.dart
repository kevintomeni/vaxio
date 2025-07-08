import 'package:bloc/bloc.dart';
import 'role_event.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<RoleSelected>((event, emit) => emit(RoleChosen(event.role)));
  }
}
