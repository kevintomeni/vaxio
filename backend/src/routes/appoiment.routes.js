const express = require('express');
const router = express.Router();
const Appointment = require('../models/appointment.model');

router.get('/recent/:userId', async (req, res) => {
  const appointments = await Appointment.find({ userId: req.params.userId }).sort({ date: -1 }).limit(5);
  res.json(appointments);
});

module.exports = router;
