import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../services/doctor_service.dart';

class DoctorDetailPage extends StatefulWidget {
  final String doctorId;
  const DoctorDetailPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  Doctor? doctor;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadDoctor();
  }

  Future<void> _loadDoctor() async {
    final d = await DoctorService().fetchDoctorById(widget.doctorId);
    setState(() {
      doctor = d;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading || doctor == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(doctor!.avatar),
                  radius: 40,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. ${doctor!.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(doctor!.specialty, style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.purple, size: 18),
                          Text('${doctor!.rating}', style: const TextStyle(color: Colors.purple)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.message, color: Colors.blue), onPressed: () {}),
                        IconButton(icon: Icon(Icons.phone, color: Colors.blue), onPressed: () {}),
                      ],
                    ),
                    Text(' 24${doctor!.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoCard(label: 'Patients', value: '+${doctor!.patients}'),
                _InfoCard(label: 'Experiences', value: doctor!.experience),
                _InfoCard(label: 'Ratings', value: '${doctor!.rating} ★'),
              ],
            ),
            const SizedBox(height: 24),
            const Align(alignment: Alignment.centerLeft, child: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: doctor!.schedule.map((date) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text(date)),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Align(alignment: Alignment.centerLeft, child: Text('About a doctor', style: TextStyle(fontWeight: FontWeight.bold))),
            Text(doctor!.about, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            const Align(alignment: Alignment.centerLeft, child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(
              children: [
                const Icon(Icons.location_on, size: 18),
                const SizedBox(width: 4),
                Expanded(child: Text(doctor!.address)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.home_work, size: 18),
                const SizedBox(width: 4),
                Expanded(child: Text(doctor!.college)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(child: Text('Map Placeholder')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/visit', arguments: {'doctorId': doctor!.id});
              },
              child: const Text('Manage Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  const _InfoCard({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
} 