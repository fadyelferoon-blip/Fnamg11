const express = require('express');
const router = express.Router();
const { login, verifyToken } = require('../controllers/authController');
const auth = require('../middleware/auth');

// POST /api/auth/login
router.post('/login', login);

// GET /api/auth/verify
router.get('/verify', auth, verifyToken);

module.exports = router;
