import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenderSelected extends ProfileEvent {
  final String gender;
  GenderSelected(this.gender);
  @override
  List<Object?> get props => [gender];
}

class BirthdayChanged extends ProfileEvent {
  final String day, month, year;
  BirthdayChanged(this.day, this.month, this.year);
  @override
  List<Object?> get props => [day, month, year];
}

class LocationSelected extends ProfileEvent {
  final String location;
  LocationSelected(this.location);
  @override
  List<Object?> get props => [location];
}

class ProfileSubmitted extends ProfileEvent {}

class CountrySelected extends ProfileEvent {
  final String country;
  CountrySelected(this.country);
  @override
  List<Object?> get props => [country];
}

class CitySelected extends ProfileEvent {
  final String city;
  CitySelected(this.city);
  @override
  List<Object?> get props => [city];
}
