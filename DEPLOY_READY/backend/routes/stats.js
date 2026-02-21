const express = require('express');
const router = express.Router();
const { getStats } = require('../controllers/statsController');
const auth = require('../middleware/auth');

// GET /api/stats
router.get('/', auth, getStats);

module.exports = router;
