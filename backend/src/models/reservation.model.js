const mongoose = require('mongoose');

const reservationSchema = new mongoose.Schema({
  doctor: { type: mongoose.Schema.Types.ObjectId, ref: 'Doctor' },
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  date: String, // ex: "26 March, 2023"
  time: String, // ex: "16:00"
  status: { type: String, default: 'pending' }, // pending, paid, cancelled
  paymentMethod: String, // 'paypal' ou 'card'
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Reservation', reservationSchema); 