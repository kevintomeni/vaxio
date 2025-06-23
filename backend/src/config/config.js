require('dotenv').config();

module.exports = {
  port: process.env.PORT || 5000,
  mongoUri: process.env.MONGODB_URI || 'mongodb://localhost:27017/vaxio',
  jwtSecret: process.env.JWT_SECRET || 'votre_secret_jwt_super_securise',
  jwtExpire: process.env.JWT_EXPIRE || '24h',
}; 