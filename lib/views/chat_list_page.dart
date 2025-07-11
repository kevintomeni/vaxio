import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemple de données fictives
    final chats = [
      {
        'name': 'Dr. Floyd Miles',
        'specialty': 'Pediatrics',
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
        'lastMessage': 'Vivamus varius odio non dui gravida, qui...',
        'time': '9:12',
        'unread': 1,
        'online': true,
      },
      {
        'name': 'Dr. Guy Hawkins',
        'specialty': 'Dentist',
        'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
        'lastMessage': 'Suspendisse efficitur orci eget nisl euismod...',
        'time': '8:01',
        'unread': 3,
        'online': true,
      },
      {
        'name': 'Dr. Jane Cooper',
        'specialty': 'Cardiologist',
        'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
        'lastMessage': 'Suspendisse efficitur orci eget nisl euismod...',
        'time': '20 Mar',
        'unread': 0,
        'online': false,
        'call': true,
      },
      {
        'name': 'Dr. Jacob Jones',
        'specialty': 'Nephrologyst',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
        'lastMessage': 'Suspendisse efficitur orci eget nisl euismod...',
        'time': '5 Mar',
        'unread': 0,
        'online': true,
      },
      {
        'name': 'Dr. Savannah Nguyen',
        'specialty': 'Urologyst',
        'avatar': 'https://randomuser.me/api/portraits/women/5.jpg',
        'lastMessage': 'Suspendisse efficitur orci eget nisl euismod...',
        'time': '3 Feb',
        'unread': 0,
        'online': true,
      },
      {
        'name': 'Dr. Annette Black',
        'specialty': 'Urologyst',
        'avatar': 'https://randomuser.me/api/portraits/women/6.jpg',
        'lastMessage': 'Suspendisse efficitur orci eget nisl euismod...',
        'time': '3 Feb',
        'unread': 0,
        'online': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final chat = chats[i];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(chat['avatar'] as String),
                        radius: 28,
                      ),
                      if (chat['online'] == true)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(chat['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chat['specialty'] as String, style: const TextStyle(color: Colors.grey)),
                      Text(chat['lastMessage'] as String, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(chat['time'] as String, style: const TextStyle(color: Colors.grey)),
                      if (int.tryParse('${chat['unread']}') != null && int.tryParse('${chat['unread']}')! > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('${chat['unread']}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              if (chat['call'] == true)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 3,
        onTap: (i) {},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
} 