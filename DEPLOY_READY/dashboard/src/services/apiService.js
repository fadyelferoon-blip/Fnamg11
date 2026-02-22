import axios from './axios';

const apiService = {
  // Auth
  login: (credentials) => axios.post('/auth/login', credentials),
  verifyToken: () => axios.get('/auth/verify'),

  // Users
  getUsers: (status = null) => {
    const params = status ? { status } : {};
    return axios.get('/users', { params });
  },
  
  // ✅ FIXED: Use PATCH and uid instead of PUT and userId
  updateUserStatus: (uid, status) => 
    axios.patch(`/users/${uid}/status`, { status }),

  // Stats
  getStats: () => axios.get('/stats'),
};

export default apiService;
