const User = require('../models/user');

const getStats = async (req, res) => {
  try {
    const totalUsers = await User.countDocuments();
    const pendingUsers = await User.countDocuments({ status: 'PENDING' });
    const approvedUsers = await User.countDocuments({ status: 'APPROVED' });
    const blockedUsers = await User.countDocuments({ status: 'BLOCKED' });

    // Get recent activity (last 7 days)
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    
    const recentUsers = await User.countDocuments({ 
      createdAt: { $gte: sevenDaysAgo } 
    });

    const activeUsers = await User.countDocuments({
      lastLogin: { $gte: sevenDaysAgo },
      status: 'APPROVED'
    });

    res.status(200).json({
      success: true,
      stats: {
        total: totalUsers,
        pending: pendingUsers,
        approved: approvedUsers,
        blocked: blockedUsers,
        recentRegistrations: recentUsers,
        activeUsers: activeUsers
      }
    });
  } catch (error) {
    console.error('Stats error:', error);
    res.status(500).json({ error: 'Server error' });
  }
};

module.exports = { getStats };
