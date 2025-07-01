const nodemailer = require('nodemailer');

module.exports = async (to, subject, text) => {
  const transporter = nodemailer.createTransport({
    // Configure ton transporteur SMTP ici
    service: 'gmail',
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });

  await transporter.sendMail({
    from: process.env.SMTP_USER,
    to,
    subject,
    text,
  });
};
