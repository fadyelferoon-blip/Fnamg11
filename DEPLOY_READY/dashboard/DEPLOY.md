# FER3OON Dashboard - Deployment Guide

## 🚀 Deploy to Railway

### Step 1: Update API URL
Edit `.env` file:
```
VITE_API_URL=https://your-backend-url.up.railway.app/api
```
**Replace with your actual backend URL from Step 3 of backend deployment!**

### Step 2: Deploy to Railway
1. Push code to GitHub (can be same repo, different folder)
2. Go to https://railway.app
3. New Project → Deploy from GitHub
4. Select repository/folder
5. Add Environment Variables:
   ```
   VITE_API_URL=https://your-backend-url.up.railway.app/api
   ```
6. Set Build Settings:
   - Build Command: `npm run build`
   - Start Command: `npx vite preview --port $PORT --host`
7. Deploy!

### Step 3: Access Dashboard
Railway will give you a URL like:
`https://your-dashboard.up.railway.app`

## 🔐 Login Credentials
- **Username:** FADY
- **Password:** AMIRA

## ✅ Features
- ✅ User management
- ✅ Approve/Block/Pending actions
- ✅ Statistics dashboard
- ✅ Filter by status
- ✅ Real-time updates

## 🔧 Local Development
```bash
npm install
npm run dev
```
Open http://localhost:3000
