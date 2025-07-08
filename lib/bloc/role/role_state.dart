import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoleInitial extends RoleState {}
class RoleChosen extends RoleState {
  final String role;
  RoleChosen(this.role);

  @override
  List<Object?> get props => [role];
}
