import { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import Layout from '../components/layout';
import apiService from '../services/apiService';
import '../styles/users.css';

const Users = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [filterStatus, setFilterStatus] = useState(null);
  const [updating, setUpdating] = useState(null);
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    if (location.state?.filterStatus) {
      setFilterStatus(location.state.filterStatus);
    }
  }, [location]);

  useEffect(() => {
    loadUsers();
  }, [filterStatus]);

  const loadUsers = async () => {
    try {
      setLoading(true);
      setError('');
      const response = await apiService.getUsers(filterStatus);
      setUsers(response.data.users);
    } catch (err) {
      setError('Failed to load users');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = async (userId, newStatus) => {
    if (!window.confirm(`Are you sure you want to change this user's status to ${newStatus}?`)) {
      return;
    }

    try {
      setUpdating(userId);
      await apiService.updateUserStatus(userId, newStatus);
      await loadUsers();
    } catch (err) {
      alert('Failed to update user status');
      console.error(err);
    } finally {
      setUpdating(null);
    }
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getStatusClass = (status) => {
    switch (status) {
      case 'APPROVED': return 'status-approved';
      case 'PENDING': return 'status-pending';
      case 'BLOCKED': return 'status-blocked';
      default: return '';
    }
  };

  return (
    <Layout>
      <div className="users-container">
        <div className="users-header">
          <button className="btn-back" onClick={() => navigate('/dashboard')}>
            ← Back to Dashboard
          </button>
          <h2>User Management</h2>
        </div>

        <div className="filter-section">
          <button 
            className={`filter-btn ${filterStatus === null ? 'active' : ''}`}
            onClick={() => setFilterStatus(null)}
          >
            All Users
          </button>
          <button 
            className={`filter-btn ${filterStatus === 'PENDING' ? 'active' : ''}`}
            onClick={() => setFilterStatus('PENDING')}
          >
            Pending
          </button>
          <button 
            className={`filter-btn ${filterStatus === 'APPROVED' ? 'active' : ''}`}
            onClick={() => setFilterStatus('APPROVED')}
          >
            Approved
          </button>
          <button 
            className={`filter-btn ${filterStatus === 'BLOCKED' ? 'active' : ''}`}
            onClick={() => setFilterStatus('BLOCKED')}
          >
            Blocked
          </button>
          <button className="btn-refresh" onClick={loadUsers}>
            Refresh
          </button>
        </div>

        {error && <div className="error-alert">{error}</div>}

        {loading ? (
          <div className="loading-container">
            <div className="spinner"></div>
            <p>Loading users...</p>
          </div>
        ) : users.length === 0 ? (
          <div className="empty-state">
            <p>No users found</p>
          </div>
        ) : (
          <div className="table-container">
            <table className="users-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>UID</th>
                  <th>Device ID</th>
                  <th>Status</th>
                  <th>Last Login</th>
                  <th>Signals</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {users.map((user) => (
                  <tr key={user._id}>
                    <td>{formatDate(user.createdAt)}</td>
                    <td className="uid-cell">{user.uid}</td>
                    <td className="device-cell">{user.deviceId}</td>
                    <td>
                      <span className={`status-badge ${getStatusClass(user.status)}`}>
                        {user.status}
                      </span>
                      {user.blockedReason && (
                        <div className="blocked-reason">{user.blockedReason}</div>
                      )}
                    </td>
                    <td>{formatDate(user.lastLogin)}</td>
                    <td className="text-center">{user.signalCount || 0}</td>
                    <td>
                      <div className="action-buttons">
                        {user.status !== 'APPROVED' && (
                          <button
                            className="btn-action btn-approve"
                            onClick={() => handleStatusChange(user._id, 'APPROVED')}
                            disabled={updating === user._id}
                          >
                            ✓ Approve
                          </button>
                        )}
                        {user.status !== 'BLOCKED' && (
                          <button
                            className="btn-action btn-block"
                            onClick={() => handleStatusChange(user._id, 'BLOCKED')}
                            disabled={updating === user._id}
                          >
                            ✕ Block
                          </button>
                        )}
                        {user.status !== 'PENDING' && (
                          <button
                            className="btn-action btn-pending"
                            onClick={() => handleStatusChange(user._id, 'PENDING')}
                            disabled={updating === user._id}
                          >
                            ⏳ Pending
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        <div className="users-count">
          Total: {users.length} user{users.length !== 1 ? 's' : ''}
        </div>
      </div>
    </Layout>
  );
};

export default Users;
