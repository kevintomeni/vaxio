const mongoose = require('mongoose');
const profileSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  gender: String,
  birthday: String,
  country: String,
  city: String,
});
module.exports = mongoose.model('Profile', profileSchema);
