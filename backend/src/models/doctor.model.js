const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
  name: String,
  specialty: String,
  avatar: String,
  rating: Number,
  reviews: Number,
  category: String,
  price: Number,
  patients: Number,
  experience: String, // ex: '+10 year'
  about: String,
  address: String,
  college: String,
  location: {
    lat: Number,
    lng: Number
  },
  schedule: [String], // ex: ['23 March', '25 March', ...]
  slots: [{
    date: String, // ex: "23 March"
    times: [String], // ex: ["9:00", "12:00", "13:00", "16:00", "16:45"]
  }],
});

module.exports = mongoose.model('Doctor', doctorSchema);
