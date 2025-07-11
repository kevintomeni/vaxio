const Chat = require('../models/chat.model');
const Message = require('../models/message.model');

exports.getUserChats = async (req, res) => {
  try {
    const { userId } = req.params;
    const chats = await Chat.find({ users: userId }).populate('users').populate('lastMessage');
    res.json({ success: true, chats });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.getChatMessages = async (req, res) => {
  try {
    const { chatId } = req.params;
    const messages = await Message.find({ chatId }).sort({ createdAt: 1 });
    res.json({ success: true, messages });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.sendMessage = async (req, res) => {
  try {
    const { chatId, sender, text, audioUrl, images } = req.body;
    const message = await Message.create({ chatId, sender, text, audioUrl, images });
    await Chat.findByIdAndUpdate(chatId, { lastMessage: message._id, updatedAt: Date.now() });
    res.json({ success: true, message });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
}; 