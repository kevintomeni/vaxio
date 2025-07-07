const express = require('express');
const router = express.Router();
const { register, login, getMe, forgotPassword, resetPassword, logout, googleAuth, googleCallback, googleMobile } = require('../controllers/auth.controller');
const { protect } = require('../middleware/auth.middleware');

router.post('/register', register);
router.post('/login', login);
router.get('/me', protect, getMe);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetPassword);
router.post('/logout', logout);
router.get('/google', googleAuth);
router.get('/google/callback', googleCallback);
router.post('/google-mobile', googleMobile);

module.exports = router; 