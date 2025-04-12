import 'package:bloc/bloc.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);

  // Démarre l'animation et émet un état pour indiquer la fin du chargement
  void startLoading() async {
    emit(true); // Indique que le chargement a commencé
    await Future.delayed(const Duration(seconds: 2)); // Simule un délai
    emit(false); // Indique que le chargement est terminé
  }
}