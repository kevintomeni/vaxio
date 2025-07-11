class VideoCall {
  final String id;
  final String callerId;
  final String calleeId;
  final String status;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isVideo;
  final bool isMuted;

  VideoCall({
    required this.id,
    required this.callerId,
    required this.calleeId,
    required this.status,
    required this.startTime,
    this.endTime,
    required this.isVideo,
    required this.isMuted,
  });

  factory VideoCall.fromJson(Map<String, dynamic> json) => VideoCall(
    id: json['_id'],
    callerId: json['caller'],
    calleeId: json['callee'],
    status: json['status'],
    startTime: DateTime.parse(json['startTime']),
    endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    isVideo: json['isVideo'] ?? true,
    isMuted: json['isMuted'] ?? false,
  );
} 