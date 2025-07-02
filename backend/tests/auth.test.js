const request = require('supertest');
const app = require('../src/server');
const mongoose = require('mongoose');
const User = require('../src/models/user.model');

describe('Auth API error cases', () => {
  beforeAll(async () => {
    await mongoose.connect('mongodb://localhost:27017/vaxio_test', { useNewUrlParser: true, useUnifiedTopology: true });
    await User.deleteMany({});
    await User.create({ name: 'Test', email: 'test@mail.com', password: 'password123', phone: '+33612345678' });
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });

  it('should not register with existing email', async () => {
    const res = await request(app)
      .post('/api/auth/register')
      .send({ name: 'Test2', email: 'test@mail.com', password: 'password123' });
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toMatch(/déjà utilisé/);
  });

  it('should not login with wrong password', async () => {
    const res = await request(app)
      .post('/api/auth/login')
      .send({ email: 'test@mail.com', password: 'wrongpass' });
    expect(res.statusCode).toBe(401);
    expect(res.body.message).toMatch(/invalides/);
  });

  it('should not send OTP to unknown email', async () => {
    const res = await request(app)
      .post('/api/auth/forgot-password')
      .send({ email: 'unknown@mail.com' });
    expect(res.statusCode).toBe(404);
    expect(res.body.message).toMatch(/non trouvé/);
  });

  it('should not reset password with wrong OTP', async () => {
    const res = await request(app)
      .post('/api/auth/reset-password')
      .send({ email: 'test@mail.com', code: '000000', password: 'newpass', confirmPassword: 'newpass' });
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toMatch(/OTP invalide/);
  });

  it('should not reset password if passwords do not match', async () => {
    // Simule l'envoi d'un OTP correct
    await User.updateOne({ email: 'test@mail.com' }, { otpCode: '123456', otpExpires: Date.now() + 60000 });
    const res = await request(app)
      .post('/api/auth/reset-password')
      .send({ email: 'test@mail.com', code: '123456', password: 'newpass', confirmPassword: 'wrongpass' });
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toMatch(/correspondent/);
  });
}); 