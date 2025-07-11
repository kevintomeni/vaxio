// backend/src/models/otp.model.js
const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
  email: String,
  code: String,
  createdAt: { type: Date, default: Date.now, expires: 300 } // expire après 5 min
});

module.exports = mongoose.model('Otp', otpSchema);
