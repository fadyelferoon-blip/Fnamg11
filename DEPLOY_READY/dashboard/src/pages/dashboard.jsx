import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Layout from '../components/layout';
import apiService from '../services/apiService';
import '../styles/dashboard.css';

const Dashboard = () => {
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    loadStats();
  }, []);

  const loadStats = async () => {
    try {
      setLoading(true);
      const response = await apiService.getStats();
      setStats(response.data.stats);
    } catch (err) {
      setError('Failed to load statistics');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const navigateToUsers = (status = null) => {
    navigate('/users', { state: { filterStatus: status } });
  };

  if (loading) {
    return (
      <Layout>
        <div className="loading-container">
          <div className="spinner"></div>
          <p>Loading dashboard...</p>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="dashboard-container">
        <div className="dashboard-header">
          <h2>Dashboard Overview</h2>
          <button className="btn-refresh" onClick={loadStats}>
            Refresh
          </button>
        </div>

        {error && <div className="error-alert">{error}</div>}

        <div className="stats-grid">
          <div 
            className="stat-card stat-total"
            onClick={() => navigateToUsers(null)}
          >
            <div className="stat-icon">👥</div>
            <div className="stat-content">
              <h3>USERS</h3>
              <p className="stat-number">{stats?.total || 0}</p>
              <span className="stat-label">Total Registered</span>
            </div>
          </div>

          <div 
            className="stat-card stat-pending"
            onClick={() => navigateToUsers('PENDING')}
          >
            <div className="stat-icon">⏳</div>
            <div className="stat-content">
              <h3>PENDING</h3>
              <p className="stat-number">{stats?.pending || 0}</p>
              <span className="stat-label">Awaiting Approval</span>
            </div>
          </div>

          <div 
            className="stat-card stat-approved"
            onClick={() => navigateToUsers('APPROVED')}
          >
            <div className="stat-icon">✅</div>
            <div className="stat-content">
              <h3>APPROVED</h3>
              <p className="stat-number">{stats?.approved || 0}</p>
              <span className="stat-label">Active Users</span>
            </div>
          </div>

          <div 
            className="stat-card stat-blocked"
            onClick={() => navigateToUsers('BLOCKED')}
          >
            <div className="stat-icon">🚫</div>
            <div className="stat-content">
              <h3>BLOCKED</h3>
              <p className="stat-number">{stats?.blocked || 0}</p>
              <span className="stat-label">Restricted Access</span>
            </div>
          </div>
        </div>

        <div className="activity-section">
          <h3>Recent Activity</h3>
          <div className="activity-cards">
            <div className="activity-card">
              <span className="activity-label">New Registrations (7 days)</span>
              <span className="activity-value">{stats?.recentRegistrations || 0}</span>
            </div>
            <div className="activity-card">
              <span className="activity-label">Active Users (7 days)</span>
              <span className="activity-value">{stats?.activeUsers || 0}</span>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default Dashboard;
