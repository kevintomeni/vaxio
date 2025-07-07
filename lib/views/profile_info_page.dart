import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Gender { male, female }

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit()
      : super(ProfileInfoState(
          gender: Gender.male,
          day: '',
          month: '',
          year: '',
          location: '',
        ));

  void selectGender(Gender gender) => emit(state.copyWith(gender: gender));
  void setDay(String day) => emit(state.copyWith(day: day));
  void setMonth(String month) => emit(state.copyWith(month: month));
  void setYear(String year) => emit(state.copyWith(year: year));
  void setLocation(String location) => emit(state.copyWith(location: location));
}

class ProfileInfoState {
  final Gender gender;
  final String day;
  final String month;
  final String year;
  final String location;

  ProfileInfoState({
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
    required this.location,
  });

  ProfileInfoState copyWith({
    Gender? gender,
    String? day,
    String? month,
    String? year,
    String? location,
  }) {
    return ProfileInfoState(
      gender: gender ?? this.gender,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      location: location ?? this.location,
    );
  }
}

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileInfoCubit(),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FB),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Center(
                        child: Image.asset('assets/images/logo.png', height: 40),
                      ),
                      const SizedBox(height: 32),
                      const Center(
                        child: Text(
                          "A little about yourself",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          "Ed laoreet eros laoreet.",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text("Your gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.read<ProfileInfoCubit>().selectGender(Gender.male),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                decoration: BoxDecoration(
                                  color: state.gender == Gender.male ? const Color(0xFF1877F2) : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: state.gender == Gender.male ? const Color(0xFF1877F2) : Colors.black12,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.male, color: state.gender == Gender.male ? Colors.white : Colors.black54, size: 32),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        color: state.gender == Gender.male ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.read<ProfileInfoCubit>().selectGender(Gender.female),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                decoration: BoxDecoration(
                                  color: state.gender == Gender.female ? const Color(0xFF1877F2) : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: state.gender == Gender.female ? const Color(0xFF1877F2) : Colors.black12,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.female, color: state.gender == Gender.female ? Colors.white : Colors.black54, size: 32),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                        color: state.gender == Gender.female ? Colors.white : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text("Your birthday", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Day'),
                              onChanged: (v) => context.read<ProfileInfoCubit>().setDay(v),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Month'),
                              onChanged: (v) => context.read<ProfileInfoCubit>().setMonth(v),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Year'),
                              onChanged: (v) => context.read<ProfileInfoCubit>().setYear(v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text("Your location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          // Ici tu peux ouvrir un sélecteur de pays/ville si tu veux
                          // Pour l'exemple, on met une valeur statique
                          context.read<ProfileInfoCubit>().setLocation("Poland, Warsaw");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              const Text('🇵🇱', style: TextStyle(fontSize: 22)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  state.location.isEmpty ? "Poland, Warsaw" : state.location,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Envoyer les infos au backend ou passer à l'étape suivante
                            // Par exemple :
                            // context.read<AuthCubit>().updateProfile(...);
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1877F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
