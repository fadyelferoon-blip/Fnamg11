# FER3OON Admin Dashboard

## Setup Instructions

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment
Edit `.env` file and update:
```
VITE_API_URL=https://your-backend-url.up.railway.app/api
```

### 3. Local Development
```bash
npm run dev
```
Open http://localhost:3000

### 4. Build for Production
```bash
npm run build
```

### 5. Deploy to Railway

#### Method 1: Railway CLI
```bash
npm install -g @railway/cli
railway login
railway init
railway up
```

#### Method 2: Railway Dashboard
1. Go to https://railway.app
2. Sign up/Login with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Railway will auto-detect Node.js
6. Add environment variable in Railway dashboard:
   - VITE_API_URL=https://your-backend-url.up.railway.app/api
7. In Settings, set:
   - Build Command: `npm run build`
   - Start Command: `npx vite preview --port $PORT --host`
8. Deploy!

## Login Credentials
- **Username**: FADY
- **Password**: AMIRA

## Features
- Dashboard with statistics
- User management table
- Filter by status (All, Pending, Approved, Blocked)
- Approve/Block/Pending actions
- Real-time updates
- Responsive design

## Tech Stack
- React 18
- Vite
- React Router
- Axios
- CSS3
