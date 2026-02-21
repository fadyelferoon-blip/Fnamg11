import { useNavigate } from 'react-router-dom';
import authService from '../services/authService';
import '../styles/layout.css';

const Layout = ({ children }) => {
  const navigate = useNavigate();

  const handleSignOut = () => {
    authService.logout();
    navigate('/');
  };

  return (
    <div className="layout">
      <header className="header">
        <div className="header-content">
          <h1 className="dashboard-title">EL FER3OON DASH</h1>
          <button className="btn-signout" onClick={handleSignOut}>
            Sign Out
          </button>
        </div>
      </header>
      <main className="main-content">
        {children}
      </main>
    </div>
  );
};

export default Layout;
