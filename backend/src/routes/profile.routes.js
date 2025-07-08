const express = require('express');
const router = express.Router();
const Profile = require('../models/profile.model');

router.post('/profile', async (req, res) => {
  const { userId, gender, birthday, country, city } = req.body;
  if (!userId || !gender || !birthday || !country || !city) {
    return res.status(400).json({ message: 'Champs manquants' });
  }
  const profile = new Profile({ userId, gender, birthday, country, city });
  await profile.save();
  res.json({ message: 'Profil enregistré', profile });
});

module.exports = router;
