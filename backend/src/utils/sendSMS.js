module.exports = async function sendSMS(phone, message) {
  // Ici, tu peux intégrer Twilio, Nexmo, etc.
  console.log(`[MOCK SMS] Envoi à ${phone} : ${message}`);
  // Simule l'envoi
  return true;
}; 