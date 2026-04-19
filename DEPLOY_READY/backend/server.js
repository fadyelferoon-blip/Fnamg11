require('dotenv').config();
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');

// Import routes
const authRoutes = require('./routes/auth');
const usersRoutes = require('./routes/users');
const statsRoutes = require('./routes/stats');

const app = express();
const PORT = process.env.PORT || 5000;

// Connect to MongoDB
connectDB();

// CORS Configuration
const allowedOrigins = [
  'https://fnamg11-production-5a3c.up.railway.app/',
  'https://fnamg11-production-c154.up.railway.app/', // ✅ ضفنا الدومين الجديد
  'http://localhost:3000',
  'http://localhost:5173'
];

const corsOptions = {
  origin: function (origin, callback) {
    // Allow requests with no origin (mobile apps / curl)
    if (!origin) return callback(null, true);

    // تنظيف الـ origin (يشيل / لو موجودة في الآخر)
    const normalizedOrigin = origin.endsWith('/') ? origin.slice(0, -1) : origin;

    const isAllowed = allowedOrigins.some(o => {
      const normalizedAllowed = o.endsWith('/') ? o.slice(0, -1) : o;
      return normalizedAllowed === normalizedOrigin;
    });

    if (isAllowed || process.env.NODE_ENV !== 'production') {
      callback(null, true);
    } else {
      console.log('❌ Blocked by CORS:', origin); // مهم للديباج
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', message: 'pong', timestamp: new Date() });
});

app.get('/ping', (req, res) => {
  res.status(200).json({ status: 'OK', message: 'pong', timestamp: new Date() });
});

app.get('/', (req, res) => {
  res.status(200).json({ 
    message: 'FER3OON API Server',
    version: '1.0.0',
    status: 'running'
  });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/stats', statsRoutes);

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).json({ error: 'Internal server error' });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📡 Environment: ${process.env.NODE_ENV}`);
});
