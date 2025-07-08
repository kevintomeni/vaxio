import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String gender;
  final String day, month, year;
  final String country;
  final String city;
  final List<String> availableCities;
  final bool isLoading;
  final bool isLoadingCities;
  final String? error;

  const ProfileState({
    this.gender = '',
    this.day = '',
    this.month = '',
    this.year = '',
    this.country = '',
    this.city = '',
    this.availableCities = const [],
    this.isLoading = false,
    this.isLoadingCities = false,
    this.error,
  });

  ProfileState copyWith({
    String? gender,
    String? day,
    String? month,
    String? year,
    String? country,
    String? city,
    List<String>? availableCities,
    bool? isLoading,
    bool? isLoadingCities,
    String? error,
  }) {
    return ProfileState(
      gender: gender ?? this.gender,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      country: country ?? this.country,
      city: city ?? this.city,
      availableCities: availableCities ?? this.availableCities,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    gender, 
    day, 
    month, 
    year, 
    country, 
    city, 
    availableCities, 
    isLoading, 
    isLoadingCities, 
    error
  ];
}
