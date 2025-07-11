const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const swaggerUi = require('swagger-ui-express');
const config = require('./config/config');
const swaggerSpec = require('./config/swagger');

// Routes
const authRoutes = require('./routes/auth.routes');
const doctorRoutes = require('./routes/doctor.routes');
const appointmentRoutes = require('./routes/appoiment.routes');
const categoryRoutes = require('./routes/categoty.routes');
const profileRoutes = require('./routes/profile.routes');
const reservationRoutes = require('./routes/reservation.routes');
const chatRoutes = require('./routes/chat.routes');
const recipeRoutes = require('./routes/recipe.routes');
const videoCallRoutes = require('./routes/video_call.routes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use('/api/auth', authRoutes);
app.use('/api/doctors', doctorRoutes);
app.use('/api/appointments', appointmentRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api', profileRoutes);
app.use('/api/reservations', reservationRoutes);
app.use('/api/chats', chatRoutes);
app.use('/api/recipes', recipeRoutes);
app.use('/api/video-calls', videoCallRoutes);

mongoose.connect(config.mongoUri)
  .then(() => console.log('Connecté à MongoDB'))
  .catch(err => console.error('Erreur de connexion à MongoDB:', err));

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ success: false, message: 'Erreur serveur', error: err.message });
});

app.listen(config.port, '0.0.0.0', () => {
  console.log(`Serveur démarré sur le port ${config.port}`);
}); 