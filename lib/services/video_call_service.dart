import 'package:dio/dio.dart';
import '../models/video_call_model.dart';
import '../core/constants/app_constants.dart';

class VideoCallService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<VideoCall> startCall({
    required String callerId,
    required String calleeId,
    bool isVideo = true,
  }) async {
    final response = await _dio.post('/video-calls', data: {
      'caller': callerId,
      'callee': calleeId,
      'isVideo': isVideo,
    });
    return VideoCall.fromJson(response.data['call']);
  }

  Future<VideoCall> endCall(String callId) async {
    final response = await _dio.patch('/video-calls/$callId/end');
    return VideoCall.fromJson(response.data['call']);
  }

  Future<VideoCall> getCallStatus(String callId) async {
    final response = await _dio.get('/video-calls/$callId/status');
    return VideoCall.fromJson(response.data['call']);
  }
} 