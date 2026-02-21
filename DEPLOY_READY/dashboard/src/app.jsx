import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/login';
import Dashboard from './pages/dashboard';
import Users from './pages/users';
import ProtectedRoute from './components/protectedRoutes';
import authService from './services/authService';
import './styles/index.css';

function App() {
  const isAuth = authService.isAuthenticated();

  return (
    <BrowserRouter>
      <Routes>
        <Route 
          path="/" 
          element={isAuth ? <Navigate to="/dashboard" replace /> : <Login />} 
        />
        <Route 
          path="/dashboard" 
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          } 
        />
        <Route 
          path="/users" 
          element={
            <ProtectedRoute>
              <Users />
            </ProtectedRoute>
          } 
        />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
