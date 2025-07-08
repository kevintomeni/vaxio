import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import 'package:country_picker/country_picker.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          DateTime? selectedDate;
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8FA),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        "A little about yourself",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Ed laoreet eros laoreet.",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text("Your gender"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => context.read<ProfileBloc>().add(GenderSelected('male')),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: state.gender == 'male' ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: state.gender == 'male' ? Colors.blue : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.male, color: state.gender == 'male' ? Colors.white : Colors.blue, size: 32),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      color: state.gender == 'male' ? Colors.white : Colors.blue,
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
                            onTap: () => context.read<ProfileBloc>().add(GenderSelected('female')),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: state.gender == 'female' ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: state.gender == 'female' ? Colors.blue : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.female, color: state.gender == 'female' ? Colors.white : Colors.blue, size: 32),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      color: state.gender == 'female' ? Colors.white : Colors.blue,
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
                    const Text("Your birthday"),
                    ListTile(
                      title: Text(
                        state.day.isNotEmpty && state.month.isNotEmpty && state.year.isNotEmpty
                          ? "${state.day}/${state.month}/${state.year}"
                          : "Select your birthday",
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(now.year - 18, 1, 1),
                          firstDate: DateTime(1900),
                          lastDate: now,
                        );
                        if (picked != null) {
                          context.read<ProfileBloc>().add(
                            BirthdayChanged(
                              picked.day.toString().padLeft(2, '0'),
                              picked.month.toString().padLeft(2, '0'),
                              picked.year.toString(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text("Your location"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  context.read<ProfileBloc>().add(CountrySelected(country.name));
                                },
                              );
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
                                  Text(
                                    state.country.isEmpty ? "Select country" : state.country,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Section ville avec dropdown
                    if (state.country.isNotEmpty) ...[
                      const Text("City"),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: state.isLoadingCities
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                    SizedBox(width: 12),
                                    Text("Chargement des villes..."),
                                  ],
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.city.isNotEmpty ? state.city : null,
                                  hint: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text("Select city"),
                                  ),
                                  isExpanded: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  items: state.availableCities.map((String city) {
                                    return DropdownMenuItem<String>(
                                      value: city,
                                      child: Text(city),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      context.read<ProfileBloc>().add(CitySelected(newValue));
                                    }
                                  },
                                ),
                              ),
                      ),
                      if (state.availableCities.isEmpty && !state.isLoadingCities && state.country.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Aucune ville trouvée pour ce pays",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.gender.isNotEmpty && 
                                   state.day.isNotEmpty && 
                                   state.month.isNotEmpty && 
                                   state.year.isNotEmpty && 
                                   state.country.isNotEmpty && 
                                   state.city.isNotEmpty &&
                                   !state.isLoading
                            ? () {
                                context.read<ProfileBloc>().add(ProfileSubmitted());
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Continue', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
