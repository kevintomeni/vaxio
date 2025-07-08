const User = require('../models/user.model');
const crypto = require('crypto');
const sendMail = require('../utils/sendMail'); // À implémenter avec nodemailer
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const jwt = require('jsonwebtoken');
const sendSMS = require('../utils/sendSMS'); // À implémenter pour l'envoi de SMS
const { OAuth2Client } = require('google-auth-library');
const OtpModel = require('../models/otp.model');

/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: Inscription d'un nouvel utilisateur
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - email
 *               - password
 *             properties:
 *               name:
 *                 type: string
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       201:
 *         description: Utilisateur créé avec succès
 *       400:
 *         description: Données invalides
 */
exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Vérifier si l'utilisateur existe
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({
        success: false,
        message: 'Cet email est déjà utilisé'
      });
    }

    // Créer l'utilisateur
    user = await User.create({
      name,
      email,
      password
    });

    sendTokenResponse(user, 201, res);
  } catch (err) {
    res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Connexion d'un utilisateur
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Connexion réussie
 *       401:
 *         description: Identifiants invalides
 */
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Valider email & password
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Veuillez fournir un email et un mot de passe'
      });
    }

    // Vérifier l'utilisateur
    const user = await User.findOne({ email }).select('+password');
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Identifiants invalides'
      });
    }

    // Vérifier le mot de passe
    const isMatch = await user.matchPassword(password);
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Identifiants invalides'
      });
    }

    sendTokenResponse(user, 200, res);
  } catch (err) {
    res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/**
 * @swagger
 * /api/auth/me:
 *   get:
 *     summary: Obtenir les informations de l'utilisateur connecté
 *     tags: [Auth]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Informations de l'utilisateur
 *       401:
 *         description: Non autorisé
 */
exports.getMe = async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    res.status(200).json({
      success: true,
      data: user
    });
  } catch (err) {
    res.status(400).json({
      success: false,
      message: err.message
    });
  }
};

/**
 * @swagger
 * /api/auth/forgot-password:
 *   post:
 *     summary: Demander la réinitialisation du mot de passe (envoi OTP par email ou téléphone)
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               phone:
 *                 type: string
 *     responses:
 *       200:
 *         description: OTP envoyé par email ou SMS
 *       404:
 *         description: Utilisateur non trouvé
 */
exports.forgotPassword = async (req, res) => {
  const { email, phone } = req.body;
  let user;
  if (email) user = await User.findOne({ email });
  else if (phone) user = await User.findOne({ phone });
  if (!user) return res.status(404).json({ message: "Utilisateur non trouvé" });

  // Génère un code OTP à 6 chiffres
  const otp = Math.floor(100000 + Math.random() * 900000).toString();
  user.otpCode = otp;
  user.otpExpires = Date.now() + 15 * 60 * 1000; // 15 minutes
  await user.save();

  if (email) {
    await sendMail(user.email, 'Votre code OTP', `Votre code de vérification est : ${otp}`);
  } else if (phone) {
    await sendSMS(user.phone, `Votre code OTP Vaxio : ${otp}`);
  }

  res.status(200).json({ message: "Code OTP envoyé" });
};

/**
 * @swagger
 * /api/auth/reset-password:
 *   post:
 *     summary: Réinitialiser le mot de passe avec OTP
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               phone:
 *                 type: string
 *               code:
 *                 type: string
 *               password:
 *                 type: string
 *               confirmPassword:
 *                 type: string
 *     responses:
 *       200:
 *         description: Mot de passe réinitialisé
 *       400:
 *         description: Code OTP invalide ou expiré
 */
exports.resetPassword = async (req, res) => {
  const { email, phone, code, password, confirmPassword } = req.body;
  let user;
  if (email) user = await User.findOne({ email });
  else if (phone) user = await User.findOne({ phone });
  if (!user || user.otpCode !== code || !user.otpExpires || user.otpExpires < Date.now()) {
    return res.status(400).json({ message: "Code OTP invalide ou expiré" });
  }
  if (password !== confirmPassword) {
    return res.status(400).json({ message: "Les mots de passe ne correspondent pas" });
  }
  user.password = password;
  user.otpCode = undefined;
  user.otpExpires = undefined;
  await user.save();
  res.status(200).json({ message: "Mot de passe réinitialisé avec succès" });
};

/**
 * @swagger
 * /api/auth/logout:
 *   post:
 *     summary: Déconnexion (côté client, il suffit de supprimer le token)
 *     tags: [Auth]
 *     responses:
 *       200:
 *         description: Déconnexion réussie
 */
exports.logout = async (req, res) => {
  // Côté JWT, il suffit de supprimer le token côté client
  res.status(200).json({ message: "Déconnexion réussie" });
};

// Fonction utilitaire pour envoyer le token
const sendTokenResponse = (user, statusCode, res) => {
  const token = user.getSignedJwtToken();

  res.status(statusCode).json({
    success: true,
    token,
    user: {
      id: user._id,
      name: user.name,
      email: user.email,
      avatar: user.avatar,
      createdAt: user.createdAt
    }
  });
};

// Google OAuth config
passport.use(new GoogleStrategy({
  clientID: process.env.GOOGLE_CLIENT_ID,
  clientSecret: process.env.GOOGLE_CLIENT_SECRET,
  callbackURL: process.env.GOOGLE_CALLBACK_URL,
}, async (accessToken, refreshToken, profile, done) => {
  try {
    let user = await User.findOne({ email: profile.emails[0].value });
    if (!user) {
      user = await User.create({
        name: profile.displayName,
        email: profile.emails[0].value,
        password: crypto.randomBytes(20).toString('hex'), // mot de passe aléatoire
        googleId: profile.id
      });
    }
    return done(null, user);
  } catch (err) {
    return done(err, null);
  }
}));

/**
 * @swagger
 * /api/auth/google:
 *   get:
 *     summary: Authentification Google (initiation)
 *     tags: [Auth]
 *     responses:
 *       302:
 *         description: Redirige vers Google
 */
exports.googleAuth = passport.authenticate('google', { scope: ['profile', 'email'] });

/**
 * @swagger
 * /api/auth/google/callback:
 *   get:
 *     summary: Callback Google OAuth
 *     tags: [Auth]
 *     responses:
 *       200:
 *         description: Connexion réussie avec Google
 *       401:
 *         description: Échec de l'authentification Google
 */
exports.googleCallback = (req, res, next) => {
  passport.authenticate('google', { session: false }, (err, user) => {
    if (err || !user) {
      return res.status(401).json({ success: false, message: 'Google Auth failed' });
    }
    // Générer un JWT
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.redirect(`${process.env.FRONTEND_URL}/login?token=${token}`);
  })(req, res, next);
};

exports.googleMobile = async (req, res) => {
  try {
    const { idToken } = req.body;
    const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);
    const ticket = await client.verifyIdToken({
      idToken,
      audience: process.env.GOOGLE_CLIENT_ID,
    });
    const payload = ticket.getPayload();
    let user = await User.findOne({ email: payload.email });
    if (!user) {
      user = await User.create({
        name: payload.name,
        email: payload.email,
        password: crypto.randomBytes(20).toString('hex'),
        googleId: payload.sub
      });
    }
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.status(200).json({
      success: true,
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email
      }
    });
  } catch (err) {
    res.status(401).json({ success: false, message: 'Google Auth failed', error: err.message });
  }
};

/**
 * @swagger
 * /api/auth/send-otp:
 *   post:
 *     summary: Envoi d'un code OTP par email
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *     responses:
 *       200:
 *         description: Code OTP envoyé
 *       400:
 *         description: Email invalide
 */
exports.sendOtp = async (req, res) => {
  const { email } = req.body;
  if (!email) {
    return res.status(400).json({ message: 'Email invalide' });
  }

  const code = Math.floor(1000 + Math.random() * 9000).toString(); // 4 chiffres
  await OtpModel.create({ email, code, expiresAt: Date.now() + 2 * 60 * 1000 }); // 2 minutes
  await sendMail(email, `Votre code OTP : ${code}`);
  res.json({ message: 'OTP envoyé' });
};

/**
 * @swagger
 * /api/auth/verify-otp:
 *   post:
 *     summary: Vérifier un code OTP
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               code:
 *                 type: string
 *     responses:
 *       200:
 *         description: OTP validé
 *       400:
 *         description: Code invalide ou expiré
 */
exports.verifyOtp = async (req, res) => {
  const { email, code } = req.body;
  const otp = await OtpModel.findOne({ email, code });
  if (!otp || otp.expiresAt < Date.now()) {
    return res.status(400).json({ message: 'Code invalide ou expiré' });
  }
  // Supprime le code après usage
  await OtpModel.deleteOne({ _id: otp._id });
  res.json({ message: 'OTP validé' });
};

/**
 * @swagger
 * /api/auth/resend-otp:
 *   post:
 *     summary: Renvoyer le code OTP
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *     responses:
 *       200:
 *         description: Code OTP renvoyé
 *       400:
 *         description: Email invalide
 */
exports.resendOtp = async (req, res) => {
  const { email } = req.body;
  if (!email) {
    return res.status(400).json({ message: 'Email invalide' });
  }

  const code = Math.floor(1000 + Math.random() * 9000).toString(); // 4 chiffres
  await OtpModel.create({ email, code, expiresAt: Date.now() + 2 * 60 * 1000 }); // 2 minutes
  await sendMail(email, `Votre code OTP : ${code}`);
  res.json({ message: 'OTP renvoyé' });
}; 