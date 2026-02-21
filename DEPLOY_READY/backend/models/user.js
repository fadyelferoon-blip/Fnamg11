const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  uid: {
    type: String,
    required: true,
    trim: true,
    index: true
  },
  deviceId: {
    type: String,
    required: true,
    trim: true,
    index: true
  },
  status: {
    type: String,
    enum: ['PENDING', 'APPROVED', 'BLOCKED'],
    default: 'PENDING'
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  lastLogin: {
    type: Date,
    default: Date.now
  },
  signalHistory: [{
    type: {
      type: String,
      enum: ['CALL', 'PUT']
    },
    timestamp: {
      type: Date,
      default: Date.now
    },
    expiryMinute: Number
  }],
  blockedReason: {
    type: String,
    default: null
  }
});

// Index for faster queries
userSchema.index({ uid: 1, deviceId: 1 });
userSchema.index({ status: 1 });

module.exports = mongoose.model('User', userSchema);
