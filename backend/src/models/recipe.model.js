const mongoose = require('mongoose');

const recipeSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  doctor: { type: mongoose.Schema.Types.ObjectId, ref: 'Doctor' },
  doctorName: String,
  doctorSpecialty: String,
  medicines: [
    {
      name: String,
      description: String,
      iconColor: String, // ex: '#FDE7E7'
    }
  ],
  recommendations: String,
  advices: [String],
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Recipe', recipeSchema); 