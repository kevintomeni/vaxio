import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender { male, female }

class ProfileInfoController extends GetxController {
  var gender = Gender.male.obs;
  var day = ''.obs;
  var month = ''.obs;
  var year = ''.obs;
  var location = ''.obs;

  void selectGender(Gender gender) => this.gender.value = gender;
  void setDay(String day) => this.day.value = day;
  void setMonth(String month) => this.month.value = month;
  void setYear(String year) => this.year.value = year;
  void setLocation(String location) => this.location.value = location;
}

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileInfoController());
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
                        onTap: () => controller.selectGender(Gender.male),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: controller.gender.value == Gender.male ? const Color(0xFF1877F2) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: controller.gender.value == Gender.male ? const Color(0xFF1877F2) : Colors.black12,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.male, color: controller.gender.value == Gender.male ? Colors.white : Colors.black54, size: 32),
                              const SizedBox(height: 4),
                              Text(
                                'Male',
                                style: TextStyle(
                                  color: controller.gender.value == Gender.male ? Colors.white : Colors.black87,
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
                        onTap: () => controller.selectGender(Gender.female),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: controller.gender.value == Gender.female ? const Color(0xFF1877F2) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: controller.gender.value == Gender.female ? const Color(0xFF1877F2) : Colors.black12,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.female, color: controller.gender.value == Gender.female ? Colors.white : Colors.black54, size: 32),
                              const SizedBox(height: 4),
                              Text(
                                'Female',
                                style: TextStyle(
                                  color: controller.gender.value == Gender.female ? Colors.white : Colors.black87,
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
                        onChanged: (v) => controller.setDay(v),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Month'),
                        onChanged: (v) => controller.setMonth(v),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Year'),
                        onChanged: (v) => controller.setYear(v),
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
                    controller.setLocation("Poland, Warsaw");
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
                          child: Obx(() => Text(
                            controller.location.value.isEmpty ? "Poland, Warsaw" : controller.location.value,
                            style: const TextStyle(fontSize: 16),
                          )),
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
                      Get.offNamed('/home');
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
  }
}
