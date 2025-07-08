const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
  name: String,
  specialty: String,
  rating: Number,
  reviews: Number,
  avatar: String,
  city: String,
});

module.exports = mongoose.model('Doctor', doctorSchema);
