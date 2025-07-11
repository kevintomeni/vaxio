const Reservation = require('../models/reservation.model');

exports.createReservation = async (req, res) => {
  try {
    const { doctorId, userId, date, time, paymentMethod } = req.body;
    const reservation = await Reservation.create({
      doctor: doctorId,
      user: userId,
      date,
      time,
      paymentMethod,
      status: 'pending'
    });
    res.json({ success: true, reservation });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getUserReservations = async (req, res) => {
  try {
    const { userId } = req.params;
    const reservations = await Reservation.find({ user: userId }).populate('doctor');
    res.json({ success: true, reservations });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.cancelReservation = async (req, res) => {
  try {
    const { id } = req.params;
    await Reservation.findByIdAndUpdate(id, { status: 'cancelled' });
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
}; 