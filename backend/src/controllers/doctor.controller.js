const Doctor = require('../models/doctor.model');

exports.getAllDoctors = async (req, res) => {
  try {
    const doctors = await Doctor.find();
    res.json({ success: true, doctors });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getCategories = async (req, res) => {
  try {
    const categories = await Doctor.distinct('category');
    res.json({ success: true, categories });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getDoctorById = async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id);
    if (!doctor) return res.status(404).json({ success: false, message: 'Not found' });
    res.json({ success: true, doctor });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getDoctorSlots = async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id);
    if (!doctor) return res.status(404).json({ success: false, message: 'Not found' });
    res.json({ success: true, slots: doctor.slots });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
}; 