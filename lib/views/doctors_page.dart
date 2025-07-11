import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../services/doctor_service.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({Key? key}) : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final DoctorService _service = DoctorService();
  List<Doctor> _doctors = [];
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final doctors = await _service.fetchDoctors();
    final categories = await _service.fetchCategories();
    setState(() {
      _doctors = doctors;
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _selectedCategory == null
        ? _doctors
        : _doctors.where((d) => d.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Example "heart"',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Categories
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: _selectedCategory == cat,
                      onSelected: (_) {
                        setState(() => _selectedCategory = cat);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Doctors list
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doc = filteredDoctors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc.avatar),
                        radius: 28,
                      ),
                      title: Text('Dr. ${doc.name}'),
                      subtitle: Text(doc.specialty),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${doc.rating}', style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                          Text('(${doc.reviews} reviews)', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/doctor-detail', arguments: {'id': doc.id});
                      },
                    ),
                  );
                },
              ),
            ),
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