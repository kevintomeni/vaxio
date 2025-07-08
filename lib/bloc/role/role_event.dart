import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoleSelected extends RoleEvent {
  final String role; // 'patient' ou 'doctor'
  RoleSelected(this.role);

  @override
  List<Object?> get props => [role];
}
