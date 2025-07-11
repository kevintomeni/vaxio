const express = require('express');
const router = express.Router();
const reservationController = require('../controllers/reservation.controller');

router.post('/', reservationController.createReservation);
router.get('/user/:userId', reservationController.getUserReservations);
router.post('/:id/cancel', reservationController.cancelReservation);

module.exports = router; 