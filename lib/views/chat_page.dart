import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemple de messages fictifs
    final messages = [
      {
        'fromDoctor': true,
        'text': 'Hello, how are you feeling? Did you manage to buy medicines?',
        'time': '7:21',
      },
      {
        'fromDoctor': false,
        'text': 'Hello, yes. Only now my headaches have intensified',
        'time': '7:24',
      },
      {
        'fromDoctor': true,
        'text': 'Please describe your pain',
        'time': '7:40',
      },
      {
        'fromDoctor': false,
        'audio': true,
        'duration': '1:24',
        'time': '7:41',
      },
      {
        'fromDoctor': true,
        'images': [
          'https://images.unsplash.com/photo-1588776814546-ec7e1b1b1b1b',
          'https://images.unsplash.com/photo-1588776814546-ec7e1b1b1b1c',
        ],
        'time': '9:12',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
              radius: 18,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Dr. Floyd Miles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Online', style: TextStyle(color: Colors.blue, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.blue),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];
                if (msg['audio'] == true) {
                  return Align(
                    alignment: msg['fromDoctor'] == true ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg['fromDoctor'] == true ? Colors.white : Colors.blue[50],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_arrow, color: Colors.blue),
                          Container(
                            width: 100,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.blue[100],
                          ),
                          Text(msg['duration'] as String, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                } else if (msg['images'] != null) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        ...List.generate((msg['images'] as List).length, (j) => Container(
                          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage((msg['images'] as List)[j]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                      ],
                    ),
                  );
                } else {
                  return Align(
                    alignment: msg['fromDoctor'] == true ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg['fromDoctor'] == true ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        msg['text'] as String,
                        style: TextStyle(
                          color: msg['fromDoctor'] == true ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Write a message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_file, color: Colors.grey),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 