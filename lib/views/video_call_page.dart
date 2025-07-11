import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:async';

class VideoCallPage extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String doctorAvatarUrl;
  const VideoCallPage({Key? key, required this.doctorName, required this.doctorSpecialty, required this.doctorAvatarUrl}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _micOn = true;
  bool _videoOn = true;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _startTimer();
    // TODO: Initialiser la connexion WebRTC ici
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final min = (_seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (_seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Stack(
          children: [
            // Vidéo distante (plein écran)
            Positioned.fill(
              child: Container(
                color: Colors.black12,
                child: RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
              ),
            ),
            // Timer
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(_formattedTime, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            // Avatar vidéo locale (en haut à droite)
            Positioned(
              top: 32,
              right: 16,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: widget.doctorAvatarUrl.isNotEmpty
                          ? Image.network(widget.doctorAvatarUrl, fit: BoxFit.cover)
                          : const Icon(Icons.person, size: 60),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.cameraswitch),
                      onPressed: () {}, // TODO: switch caméra
                    ),
                  ),
                ],
              ),
            ),
            // Infos médecin
            Positioned(
              bottom: 180,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text('Dr. ${widget.doctorName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(widget.doctorSpecialty, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Boutons contrôle
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _circleButton(
                    icon: _micOn ? Icons.mic : Icons.mic_off,
                    color: Colors.grey[300]!,
                    iconColor: Colors.black,
                    onTap: () => setState(() => _micOn = !_micOn),
                  ),
                  _circleButton(
                    icon: Icons.call_end,
                    color: Colors.red,
                    iconColor: Colors.white,
                    onTap: () => Navigator.pop(context),
                  ),
                  _circleButton(
                    icon: _videoOn ? Icons.videocam : Icons.videocam_off,
                    color: Colors.grey[300]!,
                    iconColor: Colors.black,
                    onTap: () => setState(() => _videoOn = !_videoOn),
                  ),
                ],
              ),
            ),
            // Swipe up chat
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: const [
                    Icon(Icons.keyboard_arrow_up, size: 32, color: Colors.grey),
                    Text('Swipe up to chat', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required Color color, required Color iconColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 32),
      ),
    );
  }
} 