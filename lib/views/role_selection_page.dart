import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UserRole { patient, doctor }

class RoleCubit extends Cubit<UserRole?> {
  RoleCubit() : super(null);
  void select(UserRole role) => emit(role);
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoleCubit(),
      child: BlocBuilder<RoleCubit, UserRole?>(
        builder: (context, selectedRole) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F9FB),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Logo
                  Image.asset('assets/images/logo.png', height: 40), // adapte le chemin/logo
                  const SizedBox(height: 32),
                  const Text(
                    "Let's get acquainted",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "Pellentesque placerat arcu in risus facilisis, sed laoreet eros laoreet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Sélection patient
                  GestureDetector(
                    onTap: () => context.read<RoleCubit>().select(UserRole.patient),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedRole == UserRole.patient ? const Color(0xFF1877F2) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selectedRole == UserRole.patient ? const Color(0xFF1877F2) : Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: selectedRole == UserRole.patient ? Colors.white : Colors.blue, size: 32),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I'm a patient",
                                style: TextStyle(
                                  color: selectedRole == UserRole.patient ? Colors.white : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Proin convallis libero ac nisl",
                                style: TextStyle(
                                  color: selectedRole == UserRole.patient ? Colors.white70 : Colors.black38,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Sélection doctor
                  GestureDetector(
                    onTap: () => context.read<RoleCubit>().select(UserRole.doctor),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedRole == UserRole.doctor ? const Color(0xFF1877F2) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selectedRole == UserRole.doctor ? const Color(0xFF1877F2) : Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.medical_services, color: selectedRole == UserRole.doctor ? Colors.white : Colors.black87, size: 32),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I'm a doctor",
                                style: TextStyle(
                                  color: selectedRole == UserRole.doctor ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Proin convallis libero ac nisl",
                                style: TextStyle(
                                  color: selectedRole == UserRole.doctor ? Colors.white70 : Colors.black38,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedRole == null
                            ? null
                            : () {
                                // Navigue vers la page de login/inscription en passant le rôle
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                  arguments: {'role': selectedRole == UserRole.patient ? 'patient' : 'doctor'},
                                );
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
