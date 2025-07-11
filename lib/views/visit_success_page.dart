import 'package:flutter/material.dart';
import '../models/doctor_model.dart';

class VisitSuccessPage extends StatelessWidget {
  final Doctor doctor;
  final String date;
  final String time;
  const VisitSuccessPage({Key? key, required this.doctor, required this.date, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  Icon(Icons.check_circle, color: Colors.white, size: 64),
                  SizedBox(height: 16),
                  Text('Thank you!', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(
                    'Your visit has been successfully reserved,\nplease pay for it to get an appointment\nwith the selected doctor',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(doctor.avatar),
                        radius: 28,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. ${doctor.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(doctor.specialty, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text('(${doctor.reviews} reviews)', style: const TextStyle(color: Colors.grey)),
                          Row(
                            children: [
                              Text('${doctor.rating}', style: const TextStyle(color: Colors.purple)),
                              const Icon(Icons.star, color: Colors.purple, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Date:', style: TextStyle(color: Colors.grey)),
                          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Time:', style: TextStyle(color: Colors.grey)),
                          Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Location:', style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 4),
                      Expanded(child: Text(doctor.address)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.home_work, size: 18),
                      const SizedBox(width: 4),
                      Expanded(child: Text(doctor.college)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cost:', style: TextStyle(color: Colors.grey)),
                      Text(' 4${doctor.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/payment-options');
                      },
                      child: const Text('Go to payment', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Cancel reservation', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 