const express = require('express');
const router = express.Router();
const videoCallController = require('../controllers/video_call.controller');

router.post('/', videoCallController.startCall);
router.patch('/:callId/end', videoCallController.endCall);
router.get('/:callId/status', videoCallController.getCallStatus);

module.exports = router; 