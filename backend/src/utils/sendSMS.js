const twilio = require('twilio');
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = twilio(accountSid, authToken);

module.exports = async function sendSMS(phone, message) {
  return client.messages.create({
    body: message,
    from: process.env.TWILIO_PHONE,
    to: phone
  });
}; 