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
  updateUserStatus: (userId, status) => 
    axios.put(`/users/${userId}/status`, { status }),

  // Stats
  getStats: () => axios.get('/stats'),
};

export default apiService;
