const express = require('express');
const router = express.Router();
const chatController = require('../controllers/chat.controller');

router.get('/user/:userId', chatController.getUserChats);
router.get('/:chatId/messages', chatController.getChatMessages);
router.post('/send', chatController.sendMessage);

module.exports = router; 