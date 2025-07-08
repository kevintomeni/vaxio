const mongoose = require('mongoose');

const categorySchema = new mongoose.Schema({
  name: String,
  icon: String, // nom d'icône ou URL
});

module.exports = mongoose.model('Category', categorySchema);
