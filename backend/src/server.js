const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const swaggerUi = require('swagger-ui-express');
const config = require('./config/config');
const swaggerSpec = require('./config/swagger');

// Routes
const authRoutes = require('./routes/auth.routes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Documentation Swagger
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Routes
app.use('/api/auth', authRoutes);

// Connexion à MongoDB
mongoose.connect(config.mongoUri)
  .then(() => console.log('Connecté à MongoDB'))
  .catch(err => console.error('Erreur de connexion à MongoDB:', err));

// Démarrage du serveur
app.listen(config.port, () => {
  console.log(`Serveur démarré sur le port ${config.port}`);
}); 