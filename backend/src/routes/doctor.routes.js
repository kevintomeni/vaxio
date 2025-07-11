const express = require('express');
const router = express.Router();
const doctorController = require('../controllers/doctor.controller');

router.get('/', doctorController.getAllDoctors);
router.get('/categories', doctorController.getCategories);
router.get('/:id', doctorController.getDoctorById);
router.get('/:id/slots', doctorController.getDoctorSlots);

module.exports = router;
