import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wellcome Back, Mark!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24)),
            Row(
              children: const [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('Warsaw, Poland', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Example "heart"',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.tune, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Hashtags
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildHashtag('#heart'),
                _buildHashtag('#teeth'),
                _buildHashtag('#Surgeon'),
                _buildHashtag('#eyes'),
                _buildHashtag('#more'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Recent section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Recent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('See all', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          // TODO: BlocBuilder pour les rendez-vous récents
          _buildRecentCard(
            color: Colors.blue,
            title: 'Dr. Eleanor Pena',
            subtitle: 'Pediatrics',
            reviews: 220,
            rating: 4.8,
            date: '23 Mar',
            time: '16:00',
            price: '\$80',
            avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
          ),
          _buildRecentCard(
            color: Colors.redAccent,
            title: 'Blood test',
            subtitle: 'Duis hendrerit ex nibh, non',
            reviews: null,
            rating: null,
            date: '23 Mar',
            time: null,
            price: null,
            avatar: null,
          ),
          const SizedBox(height: 24),
          // Categories
          const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategory('Cardiologist', Icons.favorite, Colors.pink[100]!),
              _buildCategory('Ophthalmologist', Icons.remove_red_eye, Colors.blue[100]!),
              _buildCategory('Dentist', Icons.medical_services, Colors.yellow[100]!),
            ],
          ),
          const SizedBox(height: 24),
          // Popular Doctors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Popular Doctors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('See all', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          // TODO: BlocBuilder pour les docteurs populaires
          _buildDoctorCard(
            name: 'Dr. Floyd Miles',
            specialty: 'Pediatrics',
            reviews: 123,
            rating: 4.9,
            avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0,
        onTap: (i) {},
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  Widget _buildHashtag(String tag) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(tag, style: const TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildRecentCard({
    required Color color,
    required String title,
    required String subtitle,
    int? reviews,
    double? rating,
    required String date,
    String? time,
    String? price,
    String? avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (avatar != null)
            CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 24),
          if (avatar != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
                if (reviews != null && rating != null)
                  Row(
                    children: [
                      Text('($reviews reviews)', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('$rating', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.white)),
                    if (time != null) ...[
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(time, style: const TextStyle(color: Colors.white)),
                    ],
                    if (price != null) ...[
                      const SizedBox(width: 12),
                      Text(price, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String name, IconData icon, Color color) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black54, size: 32),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard({
    required String name,
    required String specialty,
    required int reviews,
    required double rating,
    required String avatar,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 8)],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(specialty, style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    Text('($reviews reviews)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('$rating', style: const TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 