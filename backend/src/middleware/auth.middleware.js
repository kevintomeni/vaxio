const jwt = require('jsonwebtoken');
const User = require('../models/user.model');
const config = require('../config/config');

exports.protect = async (req, res, next) => {
  try {
    let token;

    if (
      req.headers.authorization &&
      req.headers.authorization.startsWith('Bearer')
    ) {
      token = req.headers.authorization.split(' ')[1];
    }

    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'Non autorisé à accéder à cette route'
      });
    }

    try {
      // Vérifier le token
      const decoded = jwt.verify(token, config.jwtSecret);
      req.user = await User.findById(decoded.id);
      next();
    } catch (err) {
      return res.status(401).json({
        success: false,
        message: 'Non autorisé à accéder à cette route'
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: 'Erreur serveur'
    });
  }
}; 