const express = require('express');
const router = express.Router();
const Doctor = require('../models/doctor.model');

router.get('/popular', async (req, res) => {
  const doctors = await Doctor.find().sort({ rating: -1 }).limit(5);
  res.json(doctors);
});

module.exports = router;
