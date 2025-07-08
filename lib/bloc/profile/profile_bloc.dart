import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../services/city_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GenderSelected>((event, emit) => emit(state.copyWith(gender: event.gender)));
    
    on<BirthdayChanged>((event, emit) => emit(state.copyWith(
      day: event.day, 
      month: event.month, 
      year: event.year
    )));
    
    on<LocationSelected>((event, emit) => emit(state.copyWith(city: event.location)));
    
    on<CountrySelected>((event, emit) async {
      // Mettre à jour le pays et réinitialiser la ville
      emit(state.copyWith(
        country: event.country,
        city: '', // Réinitialiser la ville quand le pays change
        availableCities: [], // Vider la liste des villes
        isLoadingCities: true,
      ));
      
      // Récupérer les villes du pays sélectionné
      try {
        final cities = await CityService.getCitiesByCountry(event.country);
        emit(state.copyWith(
          availableCities: cities,
          isLoadingCities: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          availableCities: [],
          isLoadingCities: false,
          error: 'Erreur lors du chargement des villes: $e',
        ));
      }
    });
    
    on<CitySelected>((event, emit) => emit(state.copyWith(city: event.city)));
    
    on<ProfileSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      // Appelle l'API backend ici
      try {
        // Simulation d'un appel API
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
  }
}
