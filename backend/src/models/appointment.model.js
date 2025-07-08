const mongoose = require('mongoose');

const appointmentSchema = new mongoose.Schema({
  userId: String,
  doctorId: String,
  date: Date,
  time: String,
  type: String, // ex: "Blood test"
  price: Number,
  description: String,
});

module.exports = mongoose.model('Appointment', appointmentSchema);
