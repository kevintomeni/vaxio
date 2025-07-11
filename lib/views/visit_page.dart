import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../services/doctor_service.dart';

class VisitPage extends StatefulWidget {
  final String doctorId;
  const VisitPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  List<Slot> slots = [];
  String? selectedDate;
  String? selectedTime;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    final s = await DoctorService().fetchDoctorSlots(widget.doctorId);
    setState(() {
      slots = s;
      if (slots.isNotEmpty) selectedDate = slots.first.date;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final times = slots.firstWhere((e) => e.date == selectedDate, orElse: () => Slot(date: '', times: [])).times;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cancel a visit
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('• Cancel a visit', style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoCard(label: 'Patients', value: '+423'),
                _InfoCard(label: 'Experiences', value: '+8 year'),
                _InfoCard(label: 'Ratings', value: '4.8 ★'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: slots.map((slot) => GestureDetector(
                  onTap: () => setState(() => selectedDate = slot.date),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedDate == slot.date ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(slot.date, style: TextStyle(color: selectedDate == slot.date ? Colors.white : Colors.black))),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: times.map((time) => ChoiceChip(
                label: Text(time),
                selected: selectedTime == time,
                onSelected: (_) => setState(() => selectedTime = time),
              )).toList(),
            ),
            const SizedBox(height: 24),
            // Bouton Make appointment
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: (selectedDate != null && selectedTime != null)
                    ? () {
                        // Action pour prendre rendez-vous
                      }
                    : null,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('• Make appointment', style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('About a doctor', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Pellentesque placerat arcu in risus facilisis, sed laoreet eros laoreet...', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 2,
        onTap: (i) {},
        type: BottomNavigationBarType.fixed,
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