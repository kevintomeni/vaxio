const VideoCall = require('../models/video_call.model');

exports.startCall = async (req, res) => {
  try {
    const call = await VideoCall.create(req.body);
    res.json({ success: true, call });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.endCall = async (req, res) => {
  try {
    const { callId } = req.params;
    const call = await VideoCall.findByIdAndUpdate(
      callId,
      { status: 'ended', endTime: new Date() },
      { new: true }
    );
    res.json({ success: true, call });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getCallStatus = async (req, res) => {
  try {
    const { callId } = req.params;
    const call = await VideoCall.findById(callId);
    res.json({ success: true, call });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
}; 