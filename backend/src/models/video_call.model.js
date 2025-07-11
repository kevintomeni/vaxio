const mongoose = require('mongoose');

const videoCallSchema = new mongoose.Schema({
  caller: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  callee: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  status: { type: String, enum: ['ongoing', 'ended', 'missed'], default: 'ongoing' },
  startTime: { type: Date, default: Date.now },
  endTime: { type: Date },
  isVideo: { type: Boolean, default: true },
  isMuted: { type: Boolean, default: false }
});

module.exports = mongoose.model('VideoCall', videoCallSchema); 